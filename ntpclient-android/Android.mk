# Copyright (C) 2008 The Android Open Source Project
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

LOCAL_PATH:= $(call my-dir)

SCAN_FILES_PATH  :=  $(LOCAL_PATH) 
SCAN_FILES_SUFFIX := %.cpp %.c %.cc
SCAN_All_Files := $(foreach src_path,$(SCAN_FILES_PATH), $(shell find "$(src_path)" -type f) ) 
SCAN_All_Files := $(SCAN_All_Files:$(SCAN_CPP_PATH)/./%=$(SCAN_CPP_PATH)%)
SCAN_SRC_LIST  := $(filter $(SCAN_FILES_SUFFIX),$(SCAN_All_Files)) 
SCAN_SRC_LIST  := $(SCAN_SRC_LIST:$(LOCAL_PATH)/%=%)

# 综合引入所有头文件
COMMON_C_INCLUDES_FILES := \
		$(JNI_H_INCLUDE) \
		$(call include-path-for, corecg graphics) 
		
# 综合引入所有源文件
COMMON_LIBRARY_FILES := $(SCAN_SRC_LIST)
		
COMMON_STATIC_LIBRARIES	 += 

COMMON_LOCAL_CFLAGS := -fstack-protector-all -fomit-frame-pointer -Depl_LINUX
COMMON_LOCAL_CPPFLAGS := -std=c++11


include $(CLEAR_VARS)
LOCAL_MODULE:= ntpclient

# 引入公共库
LOCAL_C_INCLUDES := $(COMMON_C_INCLUDES_FILES)
LOCAL_SRC_FILES := $(COMMON_LIBRARY_FILES) 
LOCAL_SHARED_LIBRARIES := $(COMMON_SHARED_LIBRARIES)
LOCAL_STATIC_LIBRARIES := $(COMMON_STATIC_LIBRARIES)
LOCAL_CFLAGS := $(COMMON_LOCAL_CFLAGS)
LOCAL_CPPFLAGS := $(COMMON_LOCAL_CPPFLAGS)
LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -llog
# 因为使用外部 NDK 因此这里需要置空, 避免被 Android 的编译系统编译
LOCAL_MODULE_TAGS := 

include $(BUILD_EXECUTABLE)


