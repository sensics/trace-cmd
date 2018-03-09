LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)


LOCAL_ARM_MODE := arm

LOCAL_SRC_FILES := \
	glob.c \
	trace-cmd.c \
	trace-read.c \
	trace-split.c \
	trace-listen.c \
	trace-stack.c \
	trace-hist.c \
	trace-mem.c \
	trace-snapshot.c \
	trace-util.c \
	trace-ftrace.c \
	trace-seq.c \
	trace-output.c \
	event-parse.c \
	trace-usage.c \
	trace-input.c \
	kbuffer-parse.c \
	trace-recorder.c \
	trace-restore.c \
	parse-filter.c \
	trace-record.c \
	trace-blk-hack.c

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)
#	external/libnl-headers \
#	external/openssl/include

L_CFLAGS += -D__ANDROID__

LOCAL_MODULE_TAGS := eng optional
#LOCAL_SHARED_LIBRARIES := libcrypto libnl_2
LOCAL_SHARED_LIBRARIES := \
	libc libm libdl
LOCAL_MODULE := trace-cmd

include $(BUILD_EXECUTABLE)
