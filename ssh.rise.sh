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

clone_trees() {
echo -e "${blue}Device Tree Cloning ${clear}"
git clone git@github.com:RisingOSS-devices/device_realme_bladerunner.git -b a14 device/realme/bladerunner
git clone git@github.com:Matrixx-Devices/device_realme_sm8250-common.git -b udc device/realme/sm8250-common

echo -e "${blue}Vendor Tree Cloning${clear}"
git clone https://github.com/Matrixx-Devices/vendor_realme_bladerunner.git -b udc vendor/realme/bladerunner --depth=1
git clone git@github.com:Matrixx-Devices/vendor_realme_sm8250-common.git -b udc vendor/realme/sm8250-common --depth=1

echo -e "${blue}Kernel cloning ${clear}"
git clone git@github.com:Matrixx-Devices/kernel_realme_sm8250.git kernel/realme/sm8250 --depth=1
cd kernel/realme/sm8250
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -
cd ../../..

echo -e "${blue}Hardware cloning ${clear}"
rm -rf hardware/oplus
git clone git@github.com:Matrixx-Devices/hardware_oplus.git hardware/oplus -b wip

echo -e "${blue}Dolby cloning ${clear}"
git clone git@github.com:AAMIRR-ALI/hardware_dolby.git hardware/dolby

echo -e "${blue}Dolby cloning ${clear}"
git clone https://github.com/Chaitanyakm/packages_apps_ViPER4AndroidFX.git packages/apps/ViPER4AndroidFX
}

clone_fw(){
rm -rf frameworks/base
git clone git@github.com:RisingOS-staging/android_frameworks_base.git frameworks/base --depth=1

rm -rf packages/apps/crDroidSettings
git clone git@github.com:RisingOS-staging/android_packages_apps_Personalizations.git packages/apps/crDroidSettings

rm -rf packages/apps/Settings
git clone git@github.com:RisingOS-staging/android_packages_apps_Settings.git packages/apps/Settings --depth=1

rm -rf vendor/pixel-framework
git clone git@github.com:RisingOS-staging/android_vendor_pixel-framework.git vendor/pixel-framework --depth=1
}

if [ -d $DT ] && [ -d $CT ] && [ -d $VDT ] && [ -d $VCT ] && [ -d $KT ] && [ -d $HD ] ; then
    echo -e "${blue}Trees exists, Skipping !${clear}"
else
    clone_trees
fi

read -p "For Enable Press 1 Fow Fw clone: " FW
if [ "$FW" == "1" ]
then
echo -e "${blue}FW cloning ${clear}"
    clone_fw
fi

. build/envsetup.sh
riseup bladerunner && rise sb -j8
