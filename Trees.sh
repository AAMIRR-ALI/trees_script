#!/bin/bash

banner(){
clear
echo "=================================="
echo "|                                |"
echo "|  Realme X50 5G Setup Script    |"
echo "|         Branch: new            |"
echo "|  Maintained By: AAMIR          |"
echo "|                                |"
echo "=================================="
}

banner 2>1

echo dt cloning
git clone git@github.com:RisingOSS-devices/device_realme_bladerunner.git -b a14 device/realme/bladerunner
git clone git@github.com:Matrixx-Devices/device_realme_sm8250-common.git -b big device/realme/sm8250-common

echo vt cloning
git clone https://github.com/Matrixx-Devices/vendor_realme_bladerunner.git -b wip vendor/realme/bladerunner
git clone git@github.com:Matrixx-Devices/vendor_realme_sm8250-common.git -b big vendor/realme/sm8250-common

echo kt cloning
git clone git@github.com:AAMIRR-ALI/bigshot_kernel_realme_sm8250.git kernel/realme/sm8250

echo hardware
git clone git@github.com:Matrixx-Devices/hardware_oplus.git

echo bcr
git clone -b main https://github.com/Chaitanyakm/vendor_bcr.git vendor/bcr





