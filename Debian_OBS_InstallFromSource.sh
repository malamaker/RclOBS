#!/bin/sh

sudo rm /var/lib/apt/lists/lock
cd ~/

sudo apt-get update
sudo apt-get install build-essential pkg-config cmake git checkinstall
sudo apt-get install libx11-dev libgl1-mesa-dev libpulse-dev libxcomposite-dev libxinerama-dev libv4l-dev libudev-dev libfreetype6-dev libfontconfig-dev qtbase5-dev libqt5x11extras5-dev libx264-dev libxcb-xinerama0-dev libxcb-shm0-dev libjack-jackd2-dev libcurl4-openssl-dev
sudo apt-get install zlib1g-dev yasm

cd ~/
git clone --depth 1 git://source.ffmpeg.org/ffmpeg.git

cd ffmpeg
git pull

./configure --enable-shared --prefix=/usr
make -j4

sudo checkinstall --pkgname=FFmpeg --fstrans=no --backup=no --pkgversion="$(date +%Y%m%d)-git" --deldoc=yes

cd ~/
git clone https://github.com/jp9000/obs-studio.git
cd ~/obs-studio
git pull
mkdir build && cd build
cmake -DUNIX_STRUCTURE=1 -DCMAKE_INSTALL_PREFIX=/usr ..
make -j4

sudo checkinstall --pkgname=obs-studio --fstrans=no --backup=no --pkgversion="$(date +%Y%m%d)-git" --deldoc=yes