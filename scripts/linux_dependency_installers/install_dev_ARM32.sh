#!/bin/sh

# Install dependencies (cross-platform ARM 32) (PC host)

dpkg --add-architecture armhf
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
echo "Cross Compiler ARM32"
apt-get install crossbuild-essential-armhf -y
echo "Clang (for USE_CLANG_COMPILER_FEATURE)"
apt-get install clang -y
echo "-----------------------------------------------------------------------"
echo "System"
apt-get install cpuid:armhf -y
echo "-----------------------------------------------------------------------"
echo "Communications"
echo "Wifi library"
apt-get install libiw-dev:armhf -y
echo "USB"
apt-get install libudev-dev:armhf -y
apt-get install libusb-1.0.0-dev:armhf -y
echo "DBus"
apt-get install dbus libdbus-1-dev:armhf -y
echo "GLib (required by NetworkManager headers — glibconfig.h)"
apt-get install libglib2.0-dev:armhf -y
echo "Network Manager"
apt-get install network-manager-dev:armhf -y
apt-get install libnm-dev:armhf -y
apt-get install libsystemd-dev:armhf -y
echo "Bluetooth"
apt-get install libbluetooth-dev:armhf -y
echo "PCap"
apt-get install libpcap-dev:armhf -y
echo "-----------------------------------------------------------------------"
echo "Graphics"
echo "X11"
apt-get install libx11-dev:armhf -y
apt-get install libxext-dev:armhf -y
apt-get install libxxf86vm-dev:armhf -y
apt-get install libxrandr-dev:armhf -y
echo "OpenGL ES"
apt-get install libegl1-mesa-dev:armhf -y
apt-get install libgles2-mesa-dev:armhf -y
echo "-----------------------------------------------------------------------"
echo "Sound"
echo "Sound Linux"
apt-get install libasound2-dev:armhf -y
apt-get install pulseaudio:armhf -y
apt-get install libpulse-dev:armhf -y
echo "-----------------------------------------------------------------------"
echo "Databases"
echo "PostgreSQL client"
apt-get install libpq-dev:armhf -y
echo "MySQL/MariaDB client"
apt-get install libmariadb-dev-compat:armhf -y
echo "-----------------------------------------------------------------------"
apt --fix-broken install -y
