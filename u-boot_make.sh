#!/bin/sh
export U_BOOT_PATH=`pwd`
export PATH=$U_BOOT_PATH/../prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin:$PATH
export CROSS_COMPILE=arm-eabi-                                                                                               
export ARCH=arm
make distclean && \
make omap3_beagle_config  && \
make 2>&1 |tee u-boot_make.out
