#!/bin/sh

# Install dependencies (native form) (PC - ARM)

apt-get update

# -----------------------------------------------------------------------
# Compiler and Debugger
sudo apt-get install build-essential -y
apt-get install cmake -y
apt-get install g++	-y
apt-get install gdb -y
apt-get install make -y
apt-get install ninja-build -y
apt-get install rsync -y
apt-get install zip -y


# -----------------------------------------------------------------------
# System
apt-get install cpuid -y


# -----------------------------------------------------------------------
# Comunications

# Wifi library
apt-get install libiw-dev -y

# USB
apt-get install libudev-dev -y
apt-get install libusb-1.0.0-dev -y

# DBus
apt-get install dbus libdbus-1-dev -y

# Network Manager
apt-get install network-manager-dev  -y
apt-get install libnm-dev -y
apt-get install libsystemd-dev -y

# Bluetooth
apt-get install libbluetooth-dev -y

# PCap
apt-get install libpcap-dev -y


# -----------------------------------------------------------------------
# Graphics

# X11
apt-get install libx11-dev -y
apt-get install libxxf86vm-dev -y
apt-get install libxrandr-dev -y

# OpenGL
apt-get install libegl1-mesa-dev -y
apt-get install libgles2-mesa-dev -y


# -----------------------------------------------------------------------
# Sound

# Sound Linux
apt-get install libasound2-dev -y
apt-get install pulseaudio -y
apt-get install libpulse-dev -y


# -----------------------------------------------------------------------
# Databases

# PosgreSQL client
apt-get install libpq-dev -y

# MySQL client
apt-get install python3-dev  -y
apt-get install default-libmysqlclient-dev -y

