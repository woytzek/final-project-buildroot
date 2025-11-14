AESDCHAR_VERSION = 405ec4f0a7e29b23d1ebc4f483347e4f1d1a6bd6
AESDCHAR_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-woytzek.git
AESDCHAR_SITE_METHOD = git
AESDCHAR_GIT_SUBMODULES = YES

AESDCHAR_CFLAGS += -DUSE_AESD_CHAR_DEVICE=1

define KERNEL_MODULE_BUILD_CMDS
    $(MAKE) -C '$(@D)' LINUX_DIR='$(LINUX_DIR)' CC='$(TARGET_CC)' LD='$(TARGET_LD)' modules
endef

AESDCHAR_MODULE_SUBDIRS = aesd-char-driver

$(eval $(kernel-module))
$(eval $(generic-package))
