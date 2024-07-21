#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
clear='\033[0m'
HOME=$PWD
DT=$PWD/device/realme/bladerunner
CT=$PWD/device/realme/sm8250-common
VDT=$PWD/vendor/realme/bladerunner
VCT=$PWD/vendor/realme/sm8250-common
HD=$PWD/hardware/oplus
KT=$PWD/kernel/realme/sm8250
KT=$PWD/kernel/realme/sm8250/KernelSU
DEFCONFIG=vendor/sm8250_defconfig
FW=""
KernelSU=""

clone_trees() {
echo -e "${blue}Device Trees cloning ${clear}"
git clone git@github.com:RisingOSS-devices/device_realme_bladerunner.git -b a14 device/realme/bladerunner
git clone git@github.com:Matrixx-Devices/device_realme_sm8250-common.git -b big device/realme/sm8250-common

echo -e "${blue}Vendor Tree Cloning${clear}"
git clone https://github.com/Matrixx-Devices/vendor_realme_bladerunner.git -b wip vendor/realme/bladerunner
git clone git@github.com:Matrixx-Devices/vendor_realme_sm8250-common.git -b wip2 vendor/realme/sm8250-common

echo -e "${blue}Kernel cloning ${clear}"
git clone git@github.com:Matrixx-Devices/kernel_realme_sm8250.git kernel/realme/sm8250 --depth=1

echo -e "${green}KernelSU disable by default!${clear}"

echo -e "${blue}Hardware cloning ${clear}"
git clone git@github.com:Matrixx-Devices/hardware_oplus.git hardware/oplus -b wip

echo -e "${blue}BCR cloning ${clear}"
git clone -b main https://github.com/Chaitanyakm/vendor_bcr.git vendor/bcr

echo -e "${blue}Dolby cloning ${clear}"
git clone git@github.com:AAMIRR-ALI/hardware_dolby.git hardware/dolby

echo -e "${blue}Dolby cloning ${clear}"
git clone git@github.com:AAMIRR-ALI/-new-packages_apps_ViPER4AndroidFX.git packages/apps/ViPER4AndroidFX
}

setup_ksu() {
    cd $KT
    curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -
    cd $HOME
}

clone_fw(){
#rm -rf frameworks/base
#git clone git@github.com:RisingOS-staging/android_frameworks_base.git frameworks/base --depth=1

rm -rf packages/apps/crDroidSettings
git clone git@github.com:RisingOS-staging/android_packages_apps_Personalizations.git packages/apps/crDroidSettings

rm -rf packages/apps/Settings
git clone git@github.com:RisingOS-staging/android_packages_apps_Settings.git packages/apps/Settings --depth=1

#rm -rf vendor/pixel-framework
#git clone git@github.com:RisingOS-staging/android_vendor_pixel-framework.git vendor/pixel-framework --depth=1
}

if [ -d $DT ] && [ -d $CT ] && [ -d $VDT ] && [ -d $VCT ] && [ -d $KT ] && [ -d $HD ] ; then
    echo -e "${blue}Trees exists, Skipping !${clear}"
    read -p "For Enable KSU Press 1: " KernelSU
    if [ "$KernelSU" == "1" ]; then
    echo -e "${blue}KernelSU cloning ${clear}"
    setup_ksu
    fi
    if [ -d $KSU ]
    then
    echo -e "${green}KernelSU Enable Succesfully ${clear}"
    else
    echo -e "${green}Building Rom Without KSU ${clear}"
    fi 
else
    clone_trees
    read -p "For Enable KSU Press 1: " KernelSU
    if [ "$KernelSU" == "1" ]; then
    echo -e "${blue}KernelSU cloning ${clear}"
    setup_ksu
    fi
    if [ -d $KSU ]
    then
    echo -e "${green}KernelSU Enable Succesfully ${clear}"
    else
    echo -e "${green}Building Rom Without KSU ${clear}"
    fi 
fi


#read -p "For Enable Press 1 Fow Fw clone: " FW
#if [ "$FW" == "1" ]
#then
#echo -e "${blue}FW cloning ${clear}"
#    clone_fw
#fi

. build/envsetup.sh

riseup bladerunner && rise sb
