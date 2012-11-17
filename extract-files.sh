#!/bin/sh

# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


set -e

if [ $# -eq 0 ]; then
  SRC=adb
else
  if [ $# -eq 1 ]; then
    SRC=$1
  else
    echo "$0: bad number of arguments"
    echo ""
    echo "usage: $0 [PATH_TO_EXPANDED_ROM]"
    echo ""
    echo "If PATH_TO_EXPANDED_ROM is not specified, blobs will be extracted from"
    echo "the device using adb pull."
    exit 1
  fi
fi

MANUFACTURER=samsung
DEVICE=i9300
BASE=../../../vendor/$MANUFACTURER/$DEVICE/proprietary
rm -rf $BASE

mkdir -p $BASE/system/bin
mkdir -p $BASE/system/lib/hw
mkdir -p $BASE/system/usr/idc
mkdir -p $BASE/system/usr/keylayout
mkdir -p $BASE/system/vendor/firmware

if [ "$SRC" = "adb" ]; then
    adb root
    sleep 3

    adb pull /system/bin/gpsd ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/bin/gpsd
    adb pull /system/bin/rild ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/bin/rild
    adb pull /system/lib/hw/gps.exynos4.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/lib/hw/gps.exynos4.so
    adb pull /system/lib/hw/vendor-camera.exynos4.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/lib/hw/camera.smdk4x12.so
    adb pull /system/lib/hw/sensors.smdk4x12.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/lib/hw/sensors.smdk4x12.so
    adb pull /system/lib/libril.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/lib/libril.so
    adb pull /system/lib/libsec-ril.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/lib/libsec-ril.so
    adb pull /system/usr/idc/sec_touchscreen.idc ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/usr/idc/sec_touchscreen.idc
    adb pull /system/usr/keylayout/sec_touchkey.kl ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/usr/keylayout/sec_touchkey.kl
    adb pull /system/vendor/firmware/libpn544_fw.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/vendor/firmware/libpn544_fw.so
    adb pull /system/vendor/firmware/SlimISP_GD.bin ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/vendor/firmware/SlimISP_GD.bin
    adb pull /system/vendor/firmware/SlimISP_ZD.bin ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/vendor/firmware/SlimISP_ZD.bin

else
    cp $SRC/system/bin/gpsd ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/bin/gpsd
    cp $SRC/system/bin/rild ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/bin/rild
    cp $SRC/system/lib/hw/gps.exynos4.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/lib/hw/gps.exynos4.so
    cp $SRC/system/lib/hw/vendor-camera.exynos4.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/lib/hw/camera.smdk4x12.so
    cp $SRC/system/lib/hw/sensors.smdk4x12.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/lib/hw/sensors.smdk4x12.so
    cp $SRC/system/lib/libril.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/lib/libril.so
    cp $SRC/system/lib/libsec-ril.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/lib/libsec-ril.so
    cp $SRC/system/usr/idc/sec_touchscreen.idc ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/usr/idc/sec_touchscreen.idc
    cp $SRC/system/usr/keylayout/sec_touchkey.kl ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/usr/keylayout/sec_touchkey.kl
    cp $SRC/system/vendor/firmware/libpn544_fw.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/vendor/firmware/libpn544_fw.so
    cp $SRC/system/vendor/firmware/SlimISP_GD.bin ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/vendor/firmware/SlimISP_GD.bin
    cp $SRC/system/vendor/firmware/SlimISP_ZD.bin ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/system/vendor/firmware/SlimISP_ZD.bin
fi

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g | sed s/__MANUFACTURER__/$MANUFACTURER/g > ../../../vendor/$MANUFACTURER/$DEVICE/$DEVICE-vendor-blobs.mk
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := vendor/samsung/i9300

PRODUCT_COPY_FILES += \\
    \$(LOCAL_PATH)/proprietary/system/bin/gpsd:system/bin/gpsd \\
    \$(LOCAL_PATH)/proprietary/system/bin/rild:system/bin/rild

PRODUCT_COPY_FILES += \\
    \$(LOCAL_PATH)/proprietary/system/lib/hw/gps.exynos4.so:system/lib/hw/gps.exynos4.so \\
    \$(LOCAL_PATH)/proprietary/system/lib/hw/camera.smdk4x12.so:system/lib/hw/vendor-camera.exynos4.so \\
    \$(LOCAL_PATH)/proprietary/system/lib/hw/sensors.smdk4x12.so:system/lib/hw/sensors.smdk4x12.so

PRODUCT_COPY_FILES += \\
    \$(LOCAL_PATH)/proprietary/system/lib/libril.so:system/lib/libril.so \\
    \$(LOCAL_PATH)/proprietary/system/lib/libsec-ril.so:system/lib/libsec-ril.so

PRODUCT_COPY_FILES += \\
    \$(LOCAL_PATH)/proprietary/system/usr/idc/sec_touchscreen.idc:system/usr/idc/sec_touchscreen.idc

PRODUCT_COPY_FILES += \\
    \$(LOCAL_PATH)/proprietary/system/usr/keylayout/sec_touchkey.kl:system/usr/keylayout/sec_touchkey.kl

PRODUCT_COPY_FILES += \\
    \$(LOCAL_PATH)/proprietary/system/vendor/firmware/libpn544_fw.so:system/vendor/firmware/libpn544_fw.so \\
    \$(LOCAL_PATH)/proprietary/system/vendor/firmware/SlimISP_GD.bin:system/vendor/firmware/SlimISP_GD.bin \\
    \$(LOCAL_PATH)/proprietary/system/vendor/firmware/SlimISP_ZD.bin:system/vendor/firmware/SlimISP_ZD.bin


EOF

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g | sed s/__MANUFACTURER__/$MANUFACTURER/g > ../../../vendor/$MANUFACTURER/$DEVICE/$DEVICE-vendor.mk
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Pick up overlay for features that depend on non-open-source files
DEVICE_PACKAGE_OVERLAYS := vendor/__MANUFACTURER__/__DEVICE__/overlay

\$(call inherit-product, vendor/__MANUFACTURER__/__DEVICE__/__DEVICE__-vendor-blobs.mk)
EOF

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g | sed s/__MANUFACTURER__/$MANUFACTURER/g > ../../../vendor/$MANUFACTURER/$DEVICE/BoardConfigVendor.mk
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

EOF

./../../../device/samsung/smdk4412-common/extract-files.sh $@
