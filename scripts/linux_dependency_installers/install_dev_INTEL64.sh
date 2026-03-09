#!/bin/sh

# Install dependencies (native + cross-compilation host) (INTEL64)

apt-get update
echo "-----------------------------------------------------------------------"
echo "Compiler and Debugger"
echo "Compilers C++"
apt-get install build-essential -y
echo "ARM 32-bit cross-compiler"
apt-get install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf -y
echo "ARM 64-bit cross-compiler"
apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu -y
echo "Clang (for USE_CLANG_COMPILER_FEATURE)"
apt-get install clang -y
echo "cmake"
apt-get install cmake -y
echo "ccache"
apt-get install ccache -y
echo "Compiler"
apt-get install g++ -y
echo "Debugger"
apt-get install gdb -y
echo "Compiler script"
apt-get install make -y
echo "Compiler script"
apt-get install ninja-build -y
echo "rsync"
apt-get install rsync -y
echo "Zip compression"
apt-get install zip -y
echo "-----------------------------------------------------------------------"
echo "System"
apt-get install cpuid -y
echo "-----------------------------------------------------------------------"
echo "Communications"
echo "Wifi library"
apt-get install libiw-dev -y
echo "USB"
apt-get install libudev-dev -y
apt-get install libusb-1.0.0-dev -y
echo "DBus"
apt-get install dbus libdbus-1-dev -y
echo "GLib (required by NetworkManager headers)"
apt-get install libglib2.0-dev -y
echo "Network Manager"
apt-get install network-manager-dev -y
apt-get install libnm-dev -y
apt-get install libsystemd-dev -y
echo "Bluetooth"
apt-get install libbluetooth-dev -y
echo "PCap"
apt-get install libpcap-dev -y
echo "-----------------------------------------------------------------------"
echo "Graphics"
echo "X11"
apt-get install libx11-dev -y
apt-get install libxext-dev -y
apt-get install libxxf86vm-dev -y
apt-get install libxrandr-dev -y
echo "OpenGL ES"
apt-get install libegl1-mesa-dev -y
apt-get install libgles2-mesa-dev -y
echo "-----------------------------------------------------------------------"
echo "Sound"
echo "Sound Linux"
apt-get install libasound2-dev -y
apt-get install pulseaudio -y
apt-get install libpulse-dev -y
echo "-----------------------------------------------------------------------"
echo "Databases"
echo "PostgreSQL client"
apt-get install libpq-dev -y
echo "MySQL/MariaDB client"
apt-get install libmariadb-dev libmariadb-dev-compat -y
echo "-----------------------------------------------------------------------"
apt --fix-broken install -y
