
### Dependencies used by GEN in Linux (libraries) 


**There are several Bash scripts to perform this library installation.**

#### Compiler and Debugger   

    build-essential                           Compilers C/C++
    kdevelop                                  IDE with Debug.  (*)
    cmake                                     cmake  
    g++                                       Compiler	   
    gdb                                       Debugger  
    make                                      Unix Builder    
    ninja-build                               Ninja Builder   
    ccache                                    Compiler cache (speeds up recompilation)
    rsync                                     rsync 
    zip                                       Zip compression
    clang                                     Clang/LLVM compiler (for USE_CLANG_COMPILER_FEATURE)

    
#### Cross Compilers (INTEL64 host only)

    gcc-arm-linux-gnueabihf                   GCC cross-compiler for ARM32
    g++-arm-linux-gnueabihf                   G++ cross-compiler for ARM32
    gcc-aarch64-linux-gnu                     GCC cross-compiler for ARM64/RPi64
    g++-aarch64-linux-gnu                     G++ cross-compiler for ARM64/RPi64
    crossbuild-essential-armhf                Full cross-build toolchain for ARM32
    crossbuild-essential-arm64                Full cross-build toolchain for ARM64


#### System

    libiw-dev                                 Wifi library
    
    libudev-dev                               USB/udev (DIOLINUXStreamUSB, DIOLINUXGPIO)
    libusb-1.0.0-dev               
    
    dbus libdbus-1-dev                        DBus (DIOLINUXDBus, DIOLINUXNetworkManager)
    libglib2.0-dev                            GLib — required by NetworkManager headers (glibconfig.h)
    network-manager-dev                       Network Manager
    libnm-dev                                 Lib Network Manager (DIOLINUXNetworkManager)
    libsystemd-dev                            SystemD
    
    libbluetooth-dev                          Bluetooth
    libpcap-dev                               PCap (capture packets)


### Sound

    libasound2-dev                            ALSA (OpenAL ALSA backend)
    pulseaudio                    
    libpulse-dev                              PulseAudio (OpenAL PulseAudio backend)

    
### Databases 
    
    libpq-dev                                 PostgreSQL client
    libmariadb-dev                            MariaDB/MySQL dev headers
    libmariadb-dev-compat                     Provides libmysqlclient.so symlink (replaces default-libmysqlclient-dev)
    
    
### Graphics 

    libx11-dev                                X11
    libxext-dev                               X11 extensions  (required by linker: -lXext)
    libxxf86vm-dev                            X11 XFree86 video mode
    libxrandr-dev                             X11 RandR extension
    libegl1-mesa-dev                          OpenGL ES / EGL
    libgles2-mesa-dev                         OpenGL ES 2


#### Boot ###

    rc-local
    systemctl status rc-local


