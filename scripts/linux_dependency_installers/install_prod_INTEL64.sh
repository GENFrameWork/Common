#!/bin/sh

# Install runtime dependencies (native INTEL64)

apt-get update
echo "-----------------------------------------------------------------------"
echo "System"
apt-get install cpuid -y
echo "-----------------------------------------------------------------------"
echo "Communications"
echo "Wifi"
apt-get install libiw30 -y
echo "USB"
apt-get install libudev1 -y
apt-get install libusb-1.0-0 -y
echo "DBus"
apt-get install dbus libdbus-1-3 -y
echo "GLib"
apt-get install libglib2.0-0 -y
echo "Network Manager"
apt-get install network-manager -y
apt-get install libnm0 -y
apt-get install libsystemd0 -y
echo "Bluetooth"
apt-get install libbluetooth3 -y
echo "PCap"
apt-get install libpcap0.8 -y
echo "-----------------------------------------------------------------------"
echo "Graphics"
echo "X11"
apt-get install libx11-6 -y
apt-get install libxext6 -y
apt-get install libxxf86vm1 -y
apt-get install libxrandr2 -y
echo "OpenGL ES"
apt-get install libegl1 -y
apt-get install libgles2 -y
echo "-----------------------------------------------------------------------"
echo "Sound"
apt-get install libasound2 -y
apt-get install pulseaudio -y
apt-get install libpulse0 -y
echo "-----------------------------------------------------------------------"
echo "Databases"
echo "PostgreSQL client"
apt-get install libpq5 -y
echo "MySQL/MariaDB client"
apt-get install libmariadb3 -y
echo "-----------------------------------------------------------------------"
apt --fix-broken install -y
