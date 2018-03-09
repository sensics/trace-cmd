LOCAL_PATH:= $(call my-dir)

LOCAL_TRACECMD_INCLUDES := \
	$(LOCAL_PATH)/tracecmd/include \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/include/trace-cmd \
	$(LOCAL_PATH)/include/traceevent \
	$(LOCAL_PATH)/lib/trace-cmd/include \
	$(LOCAL_PATH)/lib/traceevent/include

include $(CLEAR_VARS)
LOCAL_MODULE := libtraceevent
LOCAL_MODULE_TAGS := eng debug optional
LOCAL_SRC_FILES := \
	lib/traceevent/str_error_r.c \
	lib/traceevent/trace-seq.c \
	lib/traceevent/event-plugin.c \
	lib/traceevent/kbuffer-parse.c \
	lib/traceevent/parse-utils.c \
	lib/traceevent/event-parse.c \
	lib/traceevent/parse-filter.c \
	lib/traceevent/glob.c
LOCAL_CFLAGS +=-D__ANDROID__ \
	-Wno-unused-parameter \
	-Wno-pointer-arith \
	-Wno-sign-compare
LOCAL_CFLAGS_64 += -DPLUGIN_DIR=\"/system/lib64/trace-cmd/plugins\"
LOCAL_CFLAGS_32 += -DPLUGIN_DIR=\"/system/lib/trace-cmd/plugins\"

LOCAL_C_INCLUDES := $(LOCAL_TRACECMD_INCLUDES)
LOCAL_SHARED_LIBRARIES := \
	libdl

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libtrace-cmd
LOCAL_MODULE_TAGS := eng debug optional
LOCAL_SRC_FILES := \
	lib/trace-cmd/trace-hash.c \
	lib/trace-cmd/trace-ftrace.c \
	lib/trace-cmd/trace-blk-hack.c \
	lib/trace-cmd/trace-hooks.c \
	lib/trace-cmd/trace-recorder.c \
	lib/trace-cmd/trace-util.c \
	lib/trace-cmd/trace-input.c

LOCAL_CFLAGS += -D__ANDROID__ \
	-Wno-sign-compare \
	-Wno-unused-parameter \
	-Wno-pointer-arith
LOCAL_C_INCLUDES := $(LOCAL_TRACECMD_INCLUDES)
LOCAL_SHARED_LIBRARIES := libtraceevent
include $(BUILD_SHARED_LIBRARY)


include $(CLEAR_VARS)
LOCAL_PLUGIN := function
LOCAL_MODULE := plugin_$(LOCAL_PLUGIN)
#LOCAL_MODULE_CLASS := PLUGINS
#LOCAL_MODULE_STEM := plugin_$(LOCAL_PLUGIN) # Don't want "lib" prepended
#LOCAL_NO_LIBGCC := true
#LOCAL_NO_CRT := true
LOCAL_MODULE_RELATIVE_PATH := trace-cmd/plugins
LOCAL_MODULE_TAGS := eng debug optional
LOCAL_SRC_FILES := plugins/plugin_$(LOCAL_PLUGIN).c
LOCAL_CFLAGS += -D__ANDROID__ \
	-Wno-unused-parameter

LOCAL_C_INCLUDES := $(LOCAL_TRACECMD_INCLUDES)
LOCAL_SHARED_LIBRARIES := libtrace-cmd libtraceevent
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := trace-cmd
LOCAL_MODULE_TAGS := eng debug optional
LOCAL_SRC_FILES := \
	tracecmd/trace-usage.c \
	tracecmd/trace-stack.c \
	tracecmd/trace-snapshot.c \
	tracecmd/trace-profile.c \
	tracecmd/trace-list.c \
	tracecmd/trace-msg.c \
	tracecmd/trace-output.c \
	tracecmd/trace-split.c \
	tracecmd/trace-listen.c \
	tracecmd/trace-restore.c \
	tracecmd/trace-record.c \
	tracecmd/trace-read.c \
	tracecmd/trace-check-events.c \
	tracecmd/trace-stat.c \
	tracecmd/trace-show.c \
	tracecmd/trace-hist.c \
	tracecmd/trace-mem.c \
	tracecmd/trace-cmd.c \
	tracecmd/trace-stream.c

LOCAL_CFLAGS += -D__ANDROID__ \
	-DNO_AUDIT \
	-Wno-unused-parameter \
	-Wno-pointer-arith \
	-Wno-sign-compare
LOCAL_SHARED_LIBRARIES := libtrace-cmd libtraceevent
LOCAL_C_INCLUDES := $(LOCAL_TRACECMD_INCLUDES)
# To make sure it gets installed, not because we need to link it.
LOCAL_REQUIRED_MODULES := plugin_function
include $(BUILD_EXECUTABLE)

LOCAL_TRACECMD_INCLUDES :=
