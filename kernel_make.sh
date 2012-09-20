#!/bin/sh
export KERNEL_PATH=`pwd`
export PATH=$KERNEL_PATH/../prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin:$PATH
export CROSS_COMPILE=arm-eabi-                                                                                               
export ARCH=arm
export PATH=$ANDROID_PATH/../u-boot/tools:$PATH
make omap3_beagle_android_defconfig 
make uImage -j4 2>&1 |tee kernel_make.out
make modules -j4 2>&1 |tee kernel_module.out
