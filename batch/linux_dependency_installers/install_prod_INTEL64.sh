#!/bin/sh

# Install dependencies (native form) (PC - ARM)

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
echo "-----------------------------------------------------------------------"
echo "System"
apt-get install cpuid -y
apt-get install libxrandr2 -y
echo "-----------------------------------------------------------------------"
echo "Comunications"
echo "Wifi library"
apt-get install libiw -y
echo "USB"
apt-get install libudev -y
apt-get install libusb-1.0.0 -y
echo "DBus"
apt-get install dbus libdbus-1 -y
echo "Network Manager"
apt-get install network-manager  -y
apt-get install libnm -y
apt-get install libsystemd -y
echo "Bluetooth"
apt-get install libbluetooth -y
echo "PCap"
apt-get install libpcap -y
echo "-----------------------------------------------------------------------"
echo "Graphics"
echo "X11"
apt-get install libx11 -y
apt-get install libxxf86vm -y
apt-get install libxrandr -y
echo "OpenGL"
apt-get install libegl1-mesa -y
apt-get install libgles2-mesa -y
echo "-----------------------------------------------------------------------"
echo "Sound"
echo "Sound Linux"
apt-get install libasound2 -y
apt-get install pulseaudio -y
apt-get install libpulse -y
echo "-----------------------------------------------------------------------"
echo "Databases"
echo "PosgreSQL client"
apt-get install libpq -y
echo "MySQL client"
apt-get install python3  -y
apt-get install default-libmysqlclient -y
echo "-----------------------------------------------------------------------"
apt --fix-broken install -y