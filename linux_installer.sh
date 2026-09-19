#!/bin/bash
set -e

# --- Section 0: Helper Functions and Initial Setup ---

# Root check - standard good practice for build scripts
if [ "$EUID" -eq 0 ]; then
  echo -e "\033[1;31m[ERROR] Please run this script as a regular user, not as root.\033[0m"
  exit 1
fi

# Helper functions for colored output
info() { echo -e "\n\033[1;32m$*\033[0m"; }
warn() { echo -e "\033[1;33m$*\033[0m"; }
error() { echo -e "\033[1;31m$*\033[0m"; }
prompt() { read -p "$*"; }

# Header
clear
echo -e "\033[1;36m===============================================\033[0m"
echo -e "\033[1;37m Welcome To CrystalServer Linux Installer\033[0m"
echo -e "\033[1;37m Bem-vindo ao Instalador CrystalServer Linux\033[0m"
echo -e "\033[1;37m Witamy w Instalatorze CrystalServer Linux\033[0m"
echo -e "\033[1;36m===============================================\033[0m"
echo ""
sleep 2

# --- Section 1: Language and Branch Selection ---

# Associative array to hold translations
declare -A lang

while [[ -z "${lang[Title]}" ]]; do
    clear
    echo -e "\033[1;33mPlease select your language:\033[0m"
    echo -e "\033[1;33mPor favor, selecione seu idioma:\033[0m"
    echo -e "\033[1;33mProsze wybrac swoj jezyk:\033[0m"
    echo ""
    echo "  1: English"
    echo "  2: Português (Brasil)"
    echo "  3: Polski"
    echo ""
    read -p "Enter 1, 2, or 3: " choice

    case "$choice" in
        '1')
            lang[Title]="--- Interactive CrystalServer (Canary) Compiler ---"
            lang[AdminWarning]="This script will occasionally use 'sudo' and may ask for your password to install system packages."
            lang[Step1Title]="--- STEP 1: Installing System Dependencies ---"
            lang[Step1Desc]="Updating package lists and installing required tools like git, cmake, build-essential..."
            lang[Step2Title]="--- STEP 2: Setting up GCC-12 (Debian/Ubuntu/Lingmo only) ---"
            lang[Step2Desc]="Ensuring GCC version 12 is installed and set as the default compiler..."
            lang[Step3Title]="--- STEP 3: Setting up vcpkg ---"
            lang[Step3Clone]="Cloning vcpkg repository into your home directory (~/vcpkg)..."
            lang[Step3Bootstrap]="Running the vcpkg bootstrap script..."
            lang[Step3Exists]="vcpkg directory already exists. Skipping clone and bootstrap."
            lang[Step3PromptDone]="Step 3 (vcpkg) is complete. Press Enter to continue..."
            lang[Step4Title]="--- STEP 4: Cloning CrystalServer Source ---"
            lang[Step4Clone]="Cloning CrystalServer repository (branch: %s) into your home directory (~/crystalserver)..." # %s is a placeholder
            lang[Step4Exists]="CrystalServer directory already exists. Skipping clone."
            lang[Step4PromptDone]="Step 4 (Cloning) is complete. Press Enter to continue..."
            lang[Step5Title]="--- STEP 5: Building the Project ---"
            lang[Step5Config]="Configuring the project with CMake..."
            lang[Step5Build]="Compiling the source code... This may take a long time."
            lang[Step5PromptDone]="Step 5 (Build) is complete. Press Enter to continue..."
            lang[Step6Title]="--- STEP 6: Finalizing Installation ---"
            lang[Step6Copy]="Copying the executable to the main project directory..."
            lang[Step6Perms]="Setting executable permissions on the binary (requires password)..."
            lang[DoneTitle]="BUILD COMPLETED SUCCESSFULLY!"
            lang[DonePath]="You can now run the server using the command:"
            ;;
        '2')
            lang[Title]="--- Compilador Interativo CrystalServer (Canary) ---"
            lang[AdminWarning]="Este script usará 'sudo' ocasionalmente e pode pedir sua senha para instalar pacotes do sistema."
            lang[Step1Title]="--- PASSO 1: Instalando Dependências do Sistema ---"
            lang[Step1Desc]="Atualizando listas de pacotes e instalando ferramentas como git, cmake, build-essential..."
            lang[Step2Title]="--- PASSO 2: Configurando GCC-12 (Apenas Debian/Ubuntu/Lingmo) ---"
            lang[Step2Desc]="Garantindo que a versão 12 do GCC está instalada e definida como compilador padrão..."
            lang[Step3Title]="--- PASSO 3: Configurando o vcpkg ---"
            lang[Step3Clone]="Clonando o repositório vcpkg no seu diretório home (~/vcpkg)..."
            lang[Step3Bootstrap]="Executando o script de inicialização do vcpkg..."
            lang[Step3Exists]="O diretório vcpkg já existe. Pulando clone e inicialização."
            lang[Step3PromptDone]="Passo 3 (vcpkg) concluído. Pressione Enter para continuar..."
            lang[Step4Title]="--- PASSO 4: Clonando o Código do CrystalServer ---"
            lang[Step4Clone]="Clonando o repositório CrystalServer (branch: %s) no seu diretório home (~/crystalserver)..."
            lang[Step4Exists]="O diretório CrystalServer já existe. Pulando clone."
            lang[Step4PromptDone]="Passo 4 (Clonagem) concluído. Pressione Enter para continuar..."
            lang[Step5Title]="--- PASSO 5: Compilando o Projeto ---"
            lang[Step5Config]="Configurando o projeto com CMake..."
            lang[Step5Build]="Compilando o código-fonte... Isso pode levar muito tempo."
            lang[Step5PromptDone]="Passo 5 (Compilação) concluído. Pressione Enter para continuar..."
            lang[Step6Title]="--- PASSO 6: Finalizando a Instalação ---"
            lang[Step6Copy]="Copiando o executável para o diretório principal do projeto..."
            lang[Step6Perms]="Definindo permissões de execução no binário (requer senha)..."
            lang[DoneTitle]="COMPILAÇÃO CONCLUÍDA COM SUCESSO!"
            lang[DonePath]="Você pode executar o servidor usando o comando:"
            ;;
        '3')
            lang[Title]="--- Interaktywny Kompilator CrystalServer (Canary) ---"
            lang[AdminWarning]="Ten skrypt bedzie czasami uzywal 'sudo' i moze poprosic o haslo w celu instalacji pakietow systemowych."
            lang[Step1Title]="--- KROK 1: Instalacja Zaleznosci Systemowych ---"
            lang[Step1Desc]="Aktualizowanie listy pakietow i instalowanie wymaganych narzedzi, takich jak git, cmake, build-essential..."
            lang[Step2Title]="--- KROK 2: Konfiguracja GCC-12 (Tylko Debian/Ubuntu/Lingmo) ---"
            lang[Step2Desc]="Upewnianie sie, ze GCC w wersji 12 jest zainstalowany i ustawiony jako domyslny kompilator..."
            lang[Step3Title]="--- KROK 3: Konfiguracja vcpkg ---"
            lang[Step3Clone]="Klonowanie repozytorium vcpkg do Twojego katalogu domowego (~/vcpkg)..."
            lang[Step3Bootstrap]="Uruchamianie skryptu startowego vcpkg..."
            lang[Step3Exists]="Katalog vcpkg juz istnieje. Pomijanie klonowania i uruchamiania."
            lang[Step3PromptDone]="Krok 3 (vcpkg) zakonczony. Nacisnij Enter, aby kontynuowac..."
            lang[Step4Title]="--- KROK 4: Pobieranie kodu CrystalServer ---"
            lang[Step4Clone]="Klonowanie repozytorium CrystalServer (galaz: %s) do Twojego katalogu domowego (~/crystalserver)..."
            lang[Step4Exists]="Katalog CrystalServer juz istnieje. Pomijanie klonowania."
            lang[Step4PromptDone]="Krok 4 (Klonowanie) zakonczony. Nacisnij Enter, aby kontynuowac..."
            lang[Step5Title]="--- KROK 5: Kompilacja Projektu ---"
            lang[Step5Config]="Konfigurowanie projektu za pomoca CMake..."
            lang[Step5Build]="Kompilowanie kodu zrodlowego... To moze potrwac bardzo dlugo."
            lang[Step5PromptDone]="Krok 5 (Kompilacja) zakonczony. Nacisnij Enter, aby kontynuowac..."
            lang[Step6Title]="--- KROK 6: Finalizowanie Instalacji ---"
            lang[Step6Copy]="Kopiowanie pliku wykonywalnego do glownego katalogu projektu..."
            lang[Step6Perms]="Ustawianie uprawnien do uruchamiania (wymaga hasla)..."
            lang[DoneTitle]="KOMPILACJA ZAKONCZONA SUKCESEM!"
            lang[DonePath]="Mozesz teraz uruchomic serwer za pomoca polecenia:"
            ;;
        *)
            warn "Invalid selection. Wybór nieprawidłowy. Seleção inválida."
            sleep 2
            ;;
    esac
done

# Zamiast interaktywnego wyboru gałęzi ustawiamy domyślnie 'main'.
BRANCH_NAME="main"
info "Branch set to: $BRANCH_NAME"

# --- Section 2: Main Script Body ---

clear
info "${lang[Title]}"
warn "${lang[AdminWarning]}"
echo ""

# -- Step 1: Install system packages
info "${lang[Step1Title]}"
echo "${lang[Step1Desc]}"

if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    error "Could not detect Linux distribution!"
    exit 1
fi

case "$DISTRO" in
    ubuntu|debian|lingmo)
        sudo apt-get update && sudo apt-get dist-upgrade -y
        sudo apt-get install -y git cmake build-essential autoconf libtool ca-certificates curl zip unzip tar pkg-config ninja-build ccache linux-headers-$(uname -r) acl
        ;;
    arch)
        sudo pacman -Syu --noconfirm
        sudo pacman -S --noconfirm git cmake base-devel autoconf libtool ca-certificates curl zip unzip tar pkgconf ninja ccache linux-headers acl gcc
        ;;
    fedora)
        sudo dnf update -y
        sudo dnf install -y git cmake gcc gcc-c++ make autoconf libtool ca-certificates curl zip unzip tar pkgconf-pkg-config ninja-build ccache kernel-devel acl
        ;;
    *)
        error "Unsupported distribution: $DISTRO"
        exit 1
        ;;
esac

# -- Step 2: Setup gcc-12 (Ubuntu/Debian/Lingmo only)
if [[ "$DISTRO" == "ubuntu" || "$DISTRO" == "debian" || "$DISTRO" == "lingmo" ]]; then
    info "${lang[Step2Title]}"
    echo "${lang[Step2Desc]}"
    sudo apt-get install -y gcc-12 g++-12
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 100 --slave /usr/bin/g++ g++ /usr/bin/g++-12 --slave /usr/bin/gcov gcov /usr/bin/gcov-12
    sudo update-alternatives --set gcc /usr/bin/gcc-12
fi

# -- Step 3: Clone vcpkg
info "${lang[Step3Title]}"
cd "$HOME"
if [ ! -d "vcpkg" ]; then
    echo "${lang[Step3Clone]}"
    git clone https://github.com/microsoft/vcpkg
    cd vcpkg
    echo "${lang[Step3Bootstrap]}"
    ./bootstrap-vcpkg.sh
else
    warn "${lang[Step3Exists]}"
fi
prompt "${lang[Step3PromptDone]}"

# -- Step 4: Clone CrystalServer
info "${lang[Step4Title]}"
cd "$HOME"
if [ ! -d "crystalserver" ]; then
    printf "${lang[Step4Clone]}\n" "$BRANCH_NAME"
    git clone -b "$BRANCH_NAME" https://github.com/zimbadev/crystalserver.git
else
    warn "${lang[Step4Exists]}"
fi
cd crystalserver
# Rename config file if it doesn't exist
[ ! -f config.lua ] && mv config.lua.dist config.lua
prompt "${lang[Step4PromptDone]}"


# -- Step 5: Build
info "${lang[Step5Title]}"
mkdir -p build
cd build
echo "${lang[Step5Config]}"
cmake -DCMAKE_TOOLCHAIN_FILE=~/vcpkg/scripts/buildsystems/vcpkg.cmake ..
echo "${lang[Step5Build]}"
cmake --build . --config Release

prompt "${lang[Step5PromptDone]}"

# -- Step 6: Finalize
info "${lang[Step6Title]}"
cd "$HOME/crystalserver"
echo "${lang[Step6Copy]}"
# Assuming build places binaries in build/bin
cp build/bin/crystalserver .

echo "${lang[Step6Perms]}"
sudo chmod +x crystalserver

info "${lang[DoneTitle]}"
echo "${lang[DonePath]}"
echo "  $HOME/crystalserver/crystalserver"
echo ""