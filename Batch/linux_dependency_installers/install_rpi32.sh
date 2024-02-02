#!/bin/sh
#
apt-get update
apt-get install wget rsync -y 
cd /usr
rm rpi -R
mkdir rpi
cd rpi
git clone https://github.com/raspberrypi/tools
mkdir sysroot
rsync -avz root@192.168.0.21:/lib sysroot
rsync -avz root@192.168.0.21:/usr/include sysroot/usr
rsync -avz root@192.168.0.21:/usr/lib sysroot/usr
wget https://raw.githubusercontent.com/riscv/riscv-poky/master/scripts/sysroot-relativelinks.py
chmod +x sysroot-relativelinks.py
./sysroot-relativelinks.py sysroot
cp /usr/rpi/sysroot/usr/lib/arm-linux-gnueabihf/crt1.o /usr/rpi/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/arm-linux-gnueabihf/lib
cp /usr/rpi/sysroot/usr/lib/arm-linux-gnueabihf/crti.o /usr/rpi/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/arm-linux-gnueabihf/lib
cp /usr/rpi/sysroot/usr/lib/arm-linux-gnueabihf/crtn.o /usr/rpi/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/arm-linux-gnueabihf/lib
