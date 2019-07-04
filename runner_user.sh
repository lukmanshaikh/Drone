#!/bin/bash
# Copyright (C) 2019 The Raphielscape Company LLC.
#
# Licensed under the Raphielscape Public License, Version 1.b (the "License");
# you may not use this file except in compliance with the License.
#
# CI Runner Script for Generation of blobs

# We need this directive
# shellcheck disable=1090


##### Build Env Dependencies
build_env()
{
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"/telegram
TELEGRAM_TOKEN=$(cat /tmp/tg_token)
export TELEGRAM_TOKEN
tg_sendinfo "<code>[BoT]: Meh new build is Starting!</code>"
cd ~
git clone https://github.com/akhilnarang/scripts > /dev/null 2>&1
cd scripts
bash setup/android_build_env.sh  > /dev/null 2>&1
cd ..
rm -rf scripts

echo "Build Dependencies Installed....."
}
##### Build Configs

build_conf()
{
mkdir repo
cd repo
git config --global user.email "www.mohammad.yasir.s@gmail.com"
git config --global user.name "Yasir-siddiqui"
git config --global color.ui false
export LOC=$(cat /tmp/loc)
}

run()
{
echo "Starting build!"
repo init --depth=1 -u https://github.com/ArrowOS/android_manifest.git -b arrow-9.x > /dev/null 2>&1
repo sync  -f --force-sync --no-clone-bundle -j8 > /dev/null 2>&1
git clone https://github.com/ArrowOS-Devices/android_device_asus_X00TD device/asus/X00TD
. build/envsetup.sh 
brunch X00TD
cd out/target/product/X00TD
curl -F'file=@Arrow-v9.0-X00TD-OFFICIAL-*.zip' https://0x0.st

echo "Build finished!"
}

##### Here's the blecc megik k
push_gcc()
{
tg_sendinfo "<code>Check Out New Build ;_;</code>"
echo "Job Successful!"
}

build_env
build_conf
run
push_gcc
