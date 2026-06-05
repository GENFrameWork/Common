#!/bin/sh

# Install dependencies 

apt-get update
echo "-----------------------------------------------------------------------"
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
apt-get install libiw -y
echo "USB"
apt-get install libudev -y
apt-get install libusb-1.0.0 -y
echo "DBus"
apt-get install dbus libdbus-1 -y
echo "GLib (required by NetworkManager headers)"
apt-get install libglib2.0 -y
echo "Network Manager"
apt-get install network-manager -y
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
apt-get install libxext -y
apt-get install libxxf86vm -y
apt-get install libxrandr2 -y
echo "OpenGL ES"
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
echo "PostgreSQL client"
apt-get install libpq -y
echo "MySQL/MariaDB client"
apt-get install libmariadb libmariadb-compat -y
echo "-----------------------------------------------------------------------"

