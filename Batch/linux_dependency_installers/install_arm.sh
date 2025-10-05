#!/bin/sh
#

# Install dependencies (cross-plataform ARM) (PC)

dpkg --add-architecture armhf 
apt-get update
echo "-----------------------------------------------------------------------"
echo "Compiler and Debugger"
echo "Compilers C++"
sudo apt install crossbuild-essential-armhf -y
echo "-----------------------------------------------------------------------"
echo "Comunications"
echo "Wifi library"
apt-get install libiw-dev:armhf -y
echo "USB"
apt-get install libudev-dev:armhf -y
apt-get install libusb-1.0.0-dev:armhf -y
echo "DBus"
apt-get install dbus libdbus-1-dev:armhf -y
echo "Network Manager"
apt-get install network-manager-dev:armhf  -y
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
apt-get install libxxf86vm-dev:armhf -y
apt-get install libxrandr-dev:armhf -y
echo "OpenGL"
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
echo "PosgreSQL client"
apt-get install libpq-dev:armhf -y
echo "MySQL client"
apt-get install default-libmysqlclient-dev:armhf -y
echo "-----------------------------------------------------------------------"
