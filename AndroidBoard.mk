# Copyright (c) 2010, Code Aurora Forum.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


LOCAL_PATH := $(call my-dir)

#----------------------------------------------------------------------
# Compile (L)ittle (K)ernel bootloader and the nandwrite utility
#----------------------------------------------------------------------
ifneq ($(strip $(TARGET_NO_BOOTLOADER)),true)

# Compile
include bootable/bootloader/lk/AndroidBoot.mk

INSTALLED_BOOTLOADER_TARGET := $(PRODUCT_OUT)/bootloader
file := $(INSTALLED_BOOTLOADER_TARGET)
ALL_PREBUILT += $(file)
$(file): $(TARGET_BOOTLOADER) | $(ACP)
	$(transform-prebuilt-to-target)
endif

#----------------------------------------------------------------------
# Compile Linux Kernel
#----------------------------------------------------------------------
ifeq ($(KERNEL_DEFCONFIG),)
    KERNEL_DEFCONFIG := msm8660_defconfig
endif

include kernel/AndroidKernel.mk

file := $(INSTALLED_KERNEL_TARGET)
ALL_PREBUILT += $(file)
$(file) : $(TARGET_PREBUILT_KERNEL) | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT_KEYLAYOUT)/ffa-keypad.kl
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/ffa-keypad.kl | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT_KEYLAYOUT)/fluid-keypad.kl
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/fluid-keypad.kl | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT_KEYLAYOUT)/8660_handset.kl
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/8660_handset.kl | $(ACP)
	$(transform-prebuilt-to-target)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := ffa-keypad_qwerty.kcm
include $(BUILD_KEY_CHAR_MAP)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := ffa-keypad_numeric.kcm
include $(BUILD_KEY_CHAR_MAP)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := fluid-keypad_qwerty.kcm
include $(BUILD_KEY_CHAR_MAP)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := fluid-keypad_numeric.kcm
include $(BUILD_KEY_CHAR_MAP)


file := $(TARGET_OUT)/etc/vold.fstab
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/vold.fstab | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/init.target.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.target.rc | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/etc/init.qcom.modem_links.sh
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.qcom.modem_links.sh | $(ACP)
	$(transform-prebuilt-to-target)

ifeq ($(strip $(BOARD_HAS_QCOM_WLAN)),true)
file := $(TARGET_OUT)/etc/wifi/wpa_supplicant.conf
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/wpa_supplicant.conf | $(ACP)
	$(transform-prebuilt-to-target)
endif
