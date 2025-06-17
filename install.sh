#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]; then
  echo "Please run this script as a regular user, not as root."
  exit 1
fi

# Helper function for colored output
info() { echo -e "\033[1;32m$*\033[0m"; }
warn() { echo -e "\033[1;33m$*\033[0m"; }
error() { echo -e "\033[1;31m$*\033[0m"; }

# Detect distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    error "Could not detect Linux distribution!"
    exit 1
fi

info "Detected distribution: $DISTRO"

# -- Step 1: Install system packages (requires root)
info "Installing system dependencies (this requires your password)..."
case "$DISTRO" in
    ubuntu|debian)
        sudo apt update && sudo apt dist-upgrade -y
        sudo apt install -y git cmake build-essential autoconf libtool ca-certificates curl zip unzip tar pkg-config ninja-build ccache linux-headers-$(uname -r) acl snapd

        sudo apt remove --purge cmake -y || true
        hash -r
        sudo snap install cmake --classic
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

# -- Step 2: Setup gcc-12 (Ubuntu/Debian only; user space)
if [[ "$DISTRO" == "ubuntu" || "$DISTRO" == "debian" ]]; then
    info "Setting gcc-12 as default..."
    sudo apt install -y gcc-12 g++-12
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 100 --slave /usr/bin/g++ g++ /usr/bin/g++-12 --slave /usr/bin/gcov gcov /usr/bin/gcov-12
    sudo update-alternatives --set gcc /usr/bin/gcc-12
    gcc-12 --version
    g++-12 --version
fi

# -- Step 3: Clone vcpkg (user space)
cd ~
if [ ! -d "vcpkg" ]; then
    info "Cloning vcpkg repository..."
    git clone https://github.com/microsoft/vcpkg
    cd vcpkg
    ./bootstrap-vcpkg.sh
else
    warn "vcpkg directory already exists, skipping clone."
fi

# -- Step 4: Clone CrystalServer (user space)
cd ~
if [ ! -d "crystalserver" ]; then
    info "Cloning CrystalServer repository..."
    git clone --depth 1 https://github.com/jprzimba/crystalserver.git
    cd crystalserver
    mv config.lua.dist config.lua
else
    warn "crystalserver directory already exists, skipping clone."
    cd crystalserver
fi

# -- Step 5: Build (user space)
info "Building CrystalServer..."
mkdir -p build
cd build
cmake -DCMAKE_TOOLCHAIN_FILE=~/vcpkg/scripts/buildsystems/vcpkg.cmake .. --preset linux-release
cmake --build linux-release

# -- Step 6: Copy and set permissions (copy as user, chmod as root)
cd ~/crystalserver
cp -r build/linux-release/bin/crystalserver .

info "Setting the crystalserver binary as executable..."
sudo chmod +x crystalserver

info ""
info "CrystalServer has been downloaded and built successfully!"
info "You can run the server using: ~/crystalserver/crystalserver"
