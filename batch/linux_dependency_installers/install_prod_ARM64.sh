#!/bin/sh

# Install dependencies (cross-plataform ARM 64) (PC)

dpkg --add-architecture arm64 
apt-get update
echo "-----------------------------------------------------------------------"
echo "Compiler and Debugger"
echo "Compilers C++"
apt-get install build-essential -y
echo "cmake"
apt-get install cmake -y
echo "Compiler"
apt-get install g++	-y
echo "Debugger"
apt-get install gdb -y
echo "Compiler script"
apt-get install make -y
echo "Compiler script"
apt-get install ninja-build -y
echo "rsync"
apt-get install rsync -y
echo "Zip compresion"
apt-get install zip -y
echo "Cross Compiler"
apt-get install crossbuild-essential-arm64 -y
echo "-----------------------------------------------------------------------"
echo "System"
apt-get install cpuid:arm64 -y
apt-get install libxrandr2:arm64 -y
echo "-----------------------------------------------------------------------"
echo "Comunications"
echo "Wifi library"
apt-get install libiw-dev:arm64 -y
echo "USB"
apt-get install libudev:arm64 -y
apt-get install libusb-1.0.0:arm64 -y
echo "DBus"
apt-get install dbus libdbus-1:arm64 -y
echo "Network Manager"
apt-get install network-manager:arm64  -y
apt-get install libnm:arm64 -y
apt-get install libsystemd:arm64 -y
echo "Bluetooth"
apt-get install libbluetooth:arm64 -y
echo "PCap"
apt-get install libpcap:arm64 -y
echo "-----------------------------------------------------------------------"
echo "Graphics"
echo "X11"
apt-get install libx11:arm64 -y
apt-get install libxxf86vm:arm64 -y
apt-get install libxrandr:arm64 -y
echo "OpenGL"
apt-get install libegl1-mesa:arm64 -y
apt-get install libgles2-mesa:arm64 -y
echo "-----------------------------------------------------------------------"
echo "Sound"
echo "Sound Linux"
apt-get install libasound2:arm64 -y
apt-get install pulseaudio:arm64 -y
apt-get install libpulse:arm64 -y
echo "-----------------------------------------------------------------------"
echo "Databases"
echo "PosgreSQL client"
apt-get install libpq:arm64 -y
echo "MySQL client"
apt-get install default-libmysqlclient:arm64 -y
echo "-----------------------------------------------------------------------"
apt --fix-broken install -y