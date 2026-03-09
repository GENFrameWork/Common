#!/bin/sh

# Install runtime dependencies (cross-platform ARM64)

dpkg --add-architecture arm64
apt-get update
echo "-----------------------------------------------------------------------"
echo "System"
apt-get install cpuid:arm64 -y
echo "-----------------------------------------------------------------------"
echo "Communications"
echo "Wifi"
apt-get install libiw30:arm64 -y
echo "USB"
apt-get install libudev1:arm64 -y
apt-get install libusb-1.0-0:arm64 -y
echo "DBus"
apt-get install dbus libdbus-1-3:arm64 -y
echo "GLib"
apt-get install libglib2.0-0:arm64 -y
echo "Network Manager"
apt-get install network-manager:arm64 -y
apt-get install libnm0:arm64 -y
apt-get install libsystemd0:arm64 -y
echo "Bluetooth"
apt-get install libbluetooth3:arm64 -y
echo "PCap"
apt-get install libpcap0.8:arm64 -y
echo "-----------------------------------------------------------------------"
echo "Graphics"
echo "X11"
apt-get install libx11-6:arm64 -y
apt-get install libxext6:arm64 -y
apt-get install libxxf86vm1:arm64 -y
apt-get install libxrandr2:arm64 -y
echo "OpenGL ES"
apt-get install libegl1:arm64 -y
apt-get install libgles2:arm64 -y
echo "-----------------------------------------------------------------------"
echo "Sound"
apt-get install libasound2:arm64 -y
apt-get install pulseaudio:arm64 -y
apt-get install libpulse0:arm64 -y
echo "-----------------------------------------------------------------------"
echo "Databases"
echo "PostgreSQL client"
apt-get install libpq5:arm64 -y
echo "MySQL/MariaDB client"
apt-get install libmariadb3:arm64 -y
echo "-----------------------------------------------------------------------"
apt --fix-broken install -y
