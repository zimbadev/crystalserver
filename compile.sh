#!/usr/bin/env bash
#=====================================================================
# Script para automatizar la compilación de Canary en Ubuntu 22.04 LTS
#=====================================================================

USER_HOME="/home/francisko"
CANARY_DIR="$USER_HOME/crystalserver"
VCPKG_DIR="$USER_HOME/vcpkg"

log_info()  { echo -e "\e[32m[INFO]\e[0m $*"; }
log_warn()  { echo -e "\e[33m[WARN]\e[0m $*"; }
log_error() { echo -e "\e[31m[ERROR]\e[0m $*"; }

command_exists() { command -v "$1" >/dev/null 2>&1; }

ensure_package_installed() {
    PKG="$1"
    if ! dpkg -s "$PKG" >/dev/null 2>&1; then
        log_info "Instalando paquete: $PKG ..."
        sudo apt-get install -y "$PKG"
    else
        log_info "Paquete $PKG ya está instalado."
    fi
}

set -o errexit
set -o pipefail

if [ "$EUID" -eq 0 ]; then
    log_warn "Ejecutando como root."
    export PATH="/usr/bin:$PATH"
fi

log_info "==> Configurando variables de entorno..."
export DEBIAN_FRONTEND=noninteractive
export VCPKG_ROOT="$VCPKG_DIR"
export VCPKG_FORCE_SYSTEM_BINARIES=1
export VCPKG_FEATURE_FLAGS="versions"
export VCPKG_DEFAULT_TRIPLET="x64-linux"
export CMAKE_EXPORT_COMPILE_COMMANDS=ON

read -rp "¿Guardar estas variables en ~/.bashrc? [s/N]: " guardar_vars
if [[ "$guardar_vars" =~ ^[Ss]$ ]]; then
  {
    echo "# Canary build env vars"
    echo "export VCPKG_ROOT=\"$VCPKG_DIR\""
    echo "export VCPKG_FORCE_SYSTEM_BINARIES=1"
    echo "export VCPKG_FEATURE_FLAGS=\"versions\""
    echo "export VCPKG_DEFAULT_TRIPLET=\"x64-linux\""
    echo "export CMAKE_EXPORT_COMPILE_COMMANDS=ON"
  } >> "$USER_HOME/.bashrc"
  log_info "Variables añadidas a ~/.bashrc"
fi

log_info "==> Actualizando sistema..."
sudo apt-get update -y
sudo apt-get upgrade -y

DEPENDENCIAS=(git build-essential autoconf libtool ca-certificates curl \
              zip unzip tar pkg-config ccache acl ninja-build \
              libssl-dev zlib1g-dev linux-libc-dev \
              libsasl2-dev libldap2-dev libcurl4-openssl-dev \
              software-properties-common lsb-release apt-transport-https \
              cmake gdb valgrind lldb)

for PKG in "${DEPENDENCIAS[@]}"; do
    ensure_package_installed "$PKG"
done

if ! dpkg -s "linux-headers-$(uname -r)" >/dev/null 2>&1; then
    ensure_package_installed linux-headers-generic
fi

if ! command_exists ninja; then
    log_error "Falta Ninja a pesar de instalarlo. Verifica PATH."
    exit 1
fi

log_info "==> Verificando versión de CMake..."
if command_exists cmake; then
    CMAKE_VERSION=$(cmake --version | head -n1 | awk '{print $3}')
    if [[ "$CMAKE_VERSION" == 4.* ]]; then
        log_warn "La versión de CMake ($CMAKE_VERSION) es demasiado nueva y rompe compatibilidad con libmariadb."
        log_info "Desinstalando cmake de Snap y reinstalando cmake compatible (3.22)..."
        sudo snap remove cmake || true
        sudo apt purge -y cmake || true
        sudo apt install -y cmake
    fi
fi

cmake --version

log_info "==> Instalando GCC 13..."
if ! grep -q "ubuntu-toolchain-r/test" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
    sudo apt-get update
fi

ensure_package_installed gcc-13
ensure_package_installed g++-13

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 100 \
    --slave /usr/bin/g++ g++ /usr/bin/g++-13 \
    --slave /usr/bin/gcov gcov /usr/bin/gcov-13
sudo update-alternatives --set gcc /usr/bin/gcc-13

gcc --version
g++ --version

log_info "==> Preparando vcpkg en $VCPKG_DIR..."
if [ ! -d "$VCPKG_DIR" ]; then
    cd "$USER_HOME" && git clone https://github.com/microsoft/vcpkg
    cd "$VCPKG_DIR" && ./bootstrap-vcpkg.sh
else
    cd "$VCPKG_DIR" && git pull && ./bootstrap-vcpkg.sh
fi

log_info "==> Verificando carpeta del servidor..."
if [ ! -d "$CANARY_DIR" ]; then
    log_error "No existe $CANARY_DIR"
    exit 1
fi

sudo setfacl -R -m g:www-data:rx "$CANARY_DIR"

cd "$CANARY_DIR"
if [ -f "config.lua.dist" ] && [ ! -f "config.lua" ]; then
    cp config.lua.dist config.lua
fi

log_info "==> Limpiando build anterior y artefactos de libmariadb..."
rm -rf build
rm -rf "$VCPKG_DIR/buildtrees/libmariadb"
rm -rf "$VCPKG_DIR/packages/libmariadb_x64-linux"
rm -rf "$CANARY_DIR/build/linux-release/vcpkg-manifest-install.log"
mkdir -p build && cd build

log_info "==> Ejecutando CMake..."
if cmake -G Ninja \
    -DCMAKE_MAKE_PROGRAM="$(which ninja)" \
    -DCMAKE_C_COMPILER="/usr/bin/gcc-13" \
    -DCMAKE_CXX_COMPILER="/usr/bin/g++-13" \
    -DCMAKE_TOOLCHAIN_FILE="$VCPKG_DIR/scripts/buildsystems/vcpkg.cmake" \
    .. --preset linux-release; then

    log_info "CMake configurado correctamente."
else
    log_error "Falló CMake. Mostrando log:"
    if [ -f "$CANARY_DIR/build/linux-release/vcpkg-manifest-install.log" ]; then
      tail -n 50 "$CANARY_DIR/build/linux-release/vcpkg-manifest-install.log"
    fi
    if [ -f "$VCPKG_DIR/buildtrees/libmariadb/config-x64-linux-out.log" ]; then
      echo -e "\n[INFO] Últimas líneas del log de libmariadb (config-x64-linux-out.log):"
      tail -n 50 "$VCPKG_DIR/buildtrees/libmariadb/config-x64-linux-out.log"
    fi
    if [ -f "$VCPKG_DIR/buildtrees/libmariadb/config-x64-linux-rel-CMakeCache.txt.log" ]; then
      echo -e "\n[INFO] Últimas líneas del log de libmariadb (config-x64-linux-rel-CMakeCache.txt.log):"
      tail -n 30 "$VCPKG_DIR/buildtrees/libmariadb/config-x64-linux-rel-CMakeCache.txt.log"
    fi
    exit 1
fi

log_info "==> Compilando Canary..."
if cmake --build linux-release; then
    log_info "Compilación exitosa."
else
    log_error "Falló compilación."
    exit 1
fi

cd "$CANARY_DIR"
if [ -f "build/linux-release/bin/canary" ]; then
    cp build/linux-release/bin/canary .
    sudo chmod +x canary
    log_info "Ejecutable 'canary' copiado con éxito."
else
    log_error "No se encontró el ejecutable final."
    exit 1
fi

exit 0
