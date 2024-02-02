#!/bin/sh
#

# Install dependencies (cross-plataform ARM 64) (PC)

dpkg --add-architecture arm64 
apt-get update
echo "-----------------------------------------------------------------------"
echo "Compiler and Debugger"
echo "Compilers C++"
sudo apt install crossbuild-essential-arm64 -y
echo "-----------------------------------------------------------------------"
echo "Comunications"
echo "Wifi library"
apt-get install libiw-dev:arm64 -y
echo "USB"
apt-get install libudev-dev:arm64 -y
apt-get install libusb-1.0.0-dev:arm64 -y
echo "DBus"
apt-get install dbus libdbus-1-dev:arm64 -y
echo "Network Manager"
apt-get install network-manager-dev:arm64  -y
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
apt-get install libxxf86vm-dev:arm64 -y
apt-get install libxrandr-dev:arm64 -y
echo "OpenGL"
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
echo "PosgreSQL client"
apt-get install libpq-dev:arm64 -y
echo "MySQL client"
apt-get install default-libmysqlclient-dev:arm64 -y
echo "-----------------------------------------------------------------------"
