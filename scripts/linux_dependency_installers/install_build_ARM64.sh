#!/bin/sh

# Install dependencies (cross-platform ARM64) (PC host)

dpkg --add-architecture arm64
apt-get update
echo "-----------------------------------------------------------------------"
echo "Compiler and Debugger"
echo "Compilers C++"
apt-get install build-essential -y
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
echo "Cross Compiler ARM64"
apt-get install crossbuild-essential-arm64 -y
echo "Clang (for USE_CLANG_COMPILER_FEATURE)"
apt-get install clang -y
echo "-----------------------------------------------------------------------"
echo "System"
apt-get install cpuid:arm64 -y
echo "-----------------------------------------------------------------------"
echo "Communications"
echo "Wifi library"
apt-get install libiw-dev:arm64 -y
echo "USB"
apt-get install libudev-dev:arm64 -y
apt-get install libusb-1.0.0-dev:arm64 -y
echo "DBus"
apt-get install dbus libdbus-1-dev:arm64 -y
echo "GLib (required by NetworkManager headers — glibconfig.h)"
apt-get install libglib2.0-dev:arm64 -y
echo "Network Manager"
apt-get install network-manager-dev:arm64 -y
apt-get install libnm-dev:arm64 -y
apt-get install libsystemd-dev:arm64 -y
echo "Bluetooth"
apt-get install libbluetooth-dev:arm64 -y
echo "PCap"
apt-get install libpcap-dev:arm64 -y
echo "-----------------------------------------------------------------------"
echo "Graphics"
echo "X11"
apt-get install libx11-dev:arm64 -y
apt-get install libxext-dev:arm64 -y
apt-get install libxxf86vm-dev:arm64 -y
apt-get install libxrandr-dev:arm64 -y
echo "OpenGL ES"
apt-get install libegl1-mesa-dev:arm64 -y
apt-get install libgles2-mesa-dev:arm64 -y
echo "-----------------------------------------------------------------------"
echo "Sound"
echo "Sound Linux"
apt-get install libasound2-dev:arm64 -y
apt-get install pulseaudio:arm64 -y
apt-get install libpulse-dev:arm64 -y
echo "-----------------------------------------------------------------------"
echo "Databases"
echo "PostgreSQL client"
apt-get install libpq-dev:arm64 -y
echo "MySQL/MariaDB client"
apt-get install libmariadb-dev-compat:arm64 -y
echo "-----------------------------------------------------------------------"
apt --fix-broken install -y
