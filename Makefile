DEBUG = 0
FINALPACKAGE = 1

# 以下の1行を追加
BattleCatsMod_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unsupported-availability-guard

TARGET := iphone:clang:latest:14.0
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BattleCatsMod
BattleCatsMod_FILES = Tweak.x

include $(THEOS_MAKE_PATH)/tweak.mk
