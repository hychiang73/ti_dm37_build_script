#!/bin/sh
export X_LOADER_PATH=`pwd`
export PATH=$X_LOADER_PATH/../prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin:$PATH
export CROSS_COMPILE=arm-eabi-
export ARCH=arm
make distclean && \
make omap3beagle_config  && \
make 2>&1 |tee x-loader_make.out
./signGP ./x-load.bin
mv x-load.bin.ift MLO
