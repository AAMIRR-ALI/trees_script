#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
clear='\033[0m'
DT=$PWD/device/realme/bladerunner
CT=$PWD/device/realme/sm8250-common
VDT=$PWD/vendor/realme/bladerunner
VCT=$PWD/vendor/realme/sm8250-common
HD=$PWD/hardware/oplus
KT=$PWD/kernel/realme/sm8250
VX=$PWD/packages/apps/ViPER4AndroidFX
Dolby=$PWD/hardware/dolby

clone_trees() {
#echo -e "${blue}Extras Cloning ${clear}"
#git clone git@github.com:AAMIRR-ALI/vendor_extras.git vendor/extras

echo -e "${blue}Device Tree Cloning ${clear}"
git clone https://github.com/AAMIRR-ALI/android_device_realme_bladerunner.git -b matrixx device/realme/bladerunner
git clone https://github.com/AAMIRR-ALI/android_device_realme_sm8250-common.git -b rise-stable device/realme/sm8250-common

echo -e "${blue}Vendor Tree Cloning${clear}"
git clone https://github.com/Matrixx-Devices/vendor_realme_bladerunner.git -b udc vendor/realme/bladerunner
git clone https://github.com/AAMIRR-ALI/android_vendor_realme-sm8250-common.git vendor/realme/sm8250-common --depth=1

echo -e "${blue}Hardware cloning ${clear}"
git clone https://github.com/AAMIRR-ALI/hardware_oplus.git -b rise-stable hardware/oplus

echo -e "${blue}Kernel cloning ${clear}"
git clone https://github.com/AAMIRR-ALI/bigshot_kernel_realme_sm8250.git kernel/realme/sm8250 --depth=1

echo -e "${blue}Dolby cloning ${clear}"
git clone https://github.com/AAMIRR-ALI/old_dolby.git hardware/dolby

#echo -e "${blue}ViperX cloning ${clear}"
#git clone https://github.com/Chaitanyakm/packages_apps_ViPER4AndroidFX.git packages/apps/ViPER4AndroidFX

}

if [ -d $DT ] && [ -d $CT ] && [ -d $VDT ] && [ -d $VCT ] && [ -d $KT ] && [ -d $HD ] && [ -d $VX ] && [ -d $Dolby ] ; then
    echo -e "${blue}Trees exists, Skipping !${clear}"
else
    clone_trees
fi

. build/envsetup.sh

brunch bladerunner
