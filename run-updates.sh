#!/bin/bash

if [ "$EUID" -ne 0 ]
    then echo -e '\033[31mPlease run as root\033[0m'
    exit
fi

echo '**************************'
echo '* Updating package lists *'
echo '**************************'

apt update -y
updateExitCode=$?
if [ $updateExitCode -ne 0 ]; then
    echo -e '\033[31mError updating package lists, exit code' $updateExitCode '\033[0m'
    exit $updateExitCode
else
    echo -e '\033[32mPackage lists updated with exit code' $updateExitCode '\033[0m'
fi

echo ''
echo '*******************************'
echo '* Listing upgradable packages *'
echo '*******************************'

apt list --upgradable -a
listExitCode=$?
if [ $listExitCode -ne 0 ]; then
    echo -e '\033[31mError listing upgradable packages, exit code' $listExitCode '\033[0m'
    exit $listExitCode
else
    echo -e '\033[32mUpgradable packages listed with exit code' $listExitCode '\033[0m'
fi

echo ''
echo '**********************'
echo '* Upgrading packages *'
echo '**********************'

apt upgrade -y
upgradeExitCode=$?
if [ $upgradeExitCode -ne 0 ]; then
    echo -e '\033[31mError upgrading packages, exit code' $upgradeExitCode '\033[0m'
    exit $upgradeExitCode
else
    echo -e '\033[32mPackages upgraded with exit code' $upgradeExitCode '\033[0m'
fi

echo ''
echo '*************************'
echo '* Installing OS updates *'
echo '*************************'

apt dist-upgrade -y
distUpgradeExitCode=$?
if [ $distUpgradeExitCode -ne 0 ]; then
    echo -e '\033[31mError installing OS updates, exit code' $distUpgradeExitCode '\033[0m'
    exit $distUpgradeExitCode
else
    echo -e '\033[32mOS updates installed with exit code' $distUpgradeExitCode '\033[0m'
fi

echo ''
echo '**************************'
echo '* Cleaning package cache *'
echo '**************************'

apt clean
cleanExitCode=$?
if [ $cleanExitCode -ne 0 ]; then
    echo -e '\033[31mError cleaning package cache, exit code' $cleanExitCode '\033[0m'
    exit $cleanExitCode
else
    echo -e '\033[32mPackage cache cleaned with exit code' $cleanExitCode '\033[0m'
fi

echo ''
echo '****************************'
echo '* Removing unused packages *'
echo '****************************'

apt autoremove -y
autoremoveExitCode=$?
if [ $autoremoveExitCode -ne 0 ]; then
    echo -e '\033[31mError removing unused packages, exit code' $autoremoveExitCode '\033[0m'
    exit $autoremoveExitCode
else
    echo -e '\033[32mUnused packages removed with exit code' $autoremoveExitCode '\033[0m'
fi

echo ''
echo '***********************'
echo '* Checking for reboot *'
echo '***********************'

if [ -f /var/run/reboot-required ]; then
    echo -e '\033[33mReboot required\033[0m'
else
    echo -e '\033[32mNo reboot required\033[0m'
fi

echo ''
echo '*********'
echo '* DONE! *'
echo '*********'
