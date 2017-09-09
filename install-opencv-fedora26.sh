#!/bin/bash

# Installation script for OpenCV 3.3.0 on Fedora 26.
# System: Dell Latitude E5570 w/ i7-6820HQ, AMD Radeon R7 M370, 16GB DDR4 RAM
# ---------------------------------------------------------------------------
# May or may not work for other distributions, I haven't had it tested.
# I wouldn't like to do this manually once again, therefore - I automate. :)


# Installing required dependencies
# --------------------------------
PACKAGE_LIST=("cmake", "eigen3-devel", "tbb-devel", "python3-devel", "gcc", "gcc-c++", "gtk2-devel", "ffmpeg", "openblas", "lapack", "blas-devel", "lapack-devel", "openblas-devel", "libv4l-devel", "ffmpeg-devel", "gstreamer-plugins-base-devel")

for PACKAGE in "${PACKAGE_LIST[@]}"
do
	echo "Installing $PACKAGE..."
	sudo dnf install $PACKAGE -y
done

sudo dnf remove beignet -y

# Cloning opencv repository
# -------------------------
mkdir -p ~/software/
cd ~/software/

git clone https://github.com/opencv/opencv.git

cd opencv
git checkout 3.3.0
mkdir build && cd build


# Setup CMake
# -----------

cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DWITH_TBB=ON -DWITH_EIGEN=ON ..
sudo make 
sudo make install

echo 'export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python3.6/site-packages"' >> ~/.bashrc
