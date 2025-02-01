ARCHS = arm64 arm64e
ifeq ($(ROOTLESS),1)
ARCHS = arm64
THEOS_PACKAGE_SCHEME = rootless
THEOS_PACKAGE_ROOTLESS = yes
TARGET = iphone:clang:latest:15.0
else
ROOTLESS = 0
TARGET = iphone:clang:latest:13.0
endif

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ZenPopup
PACKAGE_NAME = com.h7ang0.zentweak

ZenPopup_FILES = Tweak.x
ZenPopup_CFLAGS = -fobjc-arc -Wno-deprecated-declarations
ZenPopup_CFLAGS += -DROOTLESS=$(ROOTLESS)
ZenPopup_FRAMEWORKS = UIKit
ZenPopup_PRIVATE_FRAMEWORKS = SpringBoardServices

include $(THEOS_MAKE_PATH)/tweak.mk

after-package::
	@echo " [INFO] Rootless package generated at: $(THEOS_PACKAGE_DIR)"
	@if [ "$(ROOTLESS)" = "1" ]; then \
		DEB_NAME=$$(ls $(THEOS_PACKAGE_DIR)/$(PACKAGE_NAME)_*iphoneos-arm*.deb 2>/dev/null); \
		if [ -z "$$DEB_NAME" ]; then \
			echo " [ERROR] No deb file found"; \
			exit 1; \
		fi; \
		mv "$$DEB_NAME" "$(THEOS_PACKAGE_DIR)/$(PACKAGE_NAME)_rootless.deb"; \
	fi 