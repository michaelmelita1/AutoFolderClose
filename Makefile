FINALPACKAGE=1
THEOS_PACKAGE_SCHEME=rootless
ARCHS = arm64 arm64e
TARGET := iphone:clang:latest

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AutoFolderClose
AutoFolderClose_FILES = Tweak.xm
AutoFolderClose_FRAMEWORKS = UIKit
AutoFolderClose_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"
SUBPROJECTS += autofolderclose
include $(THEOS_MAKE_PATH)/aggregate.mk
