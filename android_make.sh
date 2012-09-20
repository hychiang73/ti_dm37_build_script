#!/bin/bash

# Pretty colors
YELLOW="\033[01;33m"
NORMAL="\033[00m"
BLUE="\033[34m"

# Parameter
export ANDROID_PATH=`pwd`
export PATH=$ANDROID_PATH/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin:$PATH
export CROSS_COMPILE=arm-eabi-
export ARCH=arm
export TARGET_PRODUCT=beagleboard
export OMAPES=5.x

if [ "$1" == "clean" ]; then
    make clean
else
    make droid kernel_build u-boot_build -j4 2>&1 |tee android_make.out
fi
#make droid kernel_build wl12xx_compat -j8 2>&1 |tee android_make.out
