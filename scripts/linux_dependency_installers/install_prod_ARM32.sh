#!/bin/sh

# Install runtime dependencies (cross-platform ARM32)

dpkg --add-architecture armhf
apt-get update
echo "-----------------------------------------------------------------------"
echo "System"
apt-get install cpuid:armhf -y
echo "-----------------------------------------------------------------------"
echo "Communications"
echo "Wifi"
apt-get install libiw30:armhf -y
echo "USB"
apt-get install libudev1:armhf -y
apt-get install libusb-1.0-0:armhf -y
echo "DBus"
apt-get install dbus libdbus-1-3:armhf -y
echo "GLib"
apt-get install libglib2.0-0:armhf -y
echo "Network Manager"
apt-get install network-manager:armhf -y
apt-get install libnm0:armhf -y
apt-get install libsystemd0:armhf -y
echo "Bluetooth"
apt-get install libbluetooth3:armhf -y
echo "PCap"
apt-get install libpcap0.8:armhf -y
echo "-----------------------------------------------------------------------"
echo "Graphics"
echo "X11"
apt-get install libx11-6:armhf -y
apt-get install libxext6:armhf -y
apt-get install libxxf86vm1:armhf -y
apt-get install libxrandr2:armhf -y
echo "OpenGL ES"
apt-get install libegl1:armhf -y
apt-get install libgles2:armhf -y
echo "-----------------------------------------------------------------------"
echo "Sound"
apt-get install libasound2:armhf -y
apt-get install pulseaudio:armhf -y
apt-get install libpulse0:armhf -y
echo "-----------------------------------------------------------------------"
echo "Databases"
echo "PostgreSQL client"
apt-get install libpq5:armhf -y
echo "MySQL/MariaDB client"
apt-get install libmariadb3:armhf -y
echo "-----------------------------------------------------------------------"
apt --fix-broken install -y
