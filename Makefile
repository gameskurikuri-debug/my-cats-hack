DEBUG = 0
FINALPACKAGE = 1
TARGET := iphone:clang:latest:14.0
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BattleCatsMod
BattleCatsMod_FILES = Tweak.x
BattleCatsMod_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
