DRIVERS_VERSION = 405ec4f0a7e29b23d1ebc4f483347e4f1d1a6bd6
DRIVERS_SITE = git@github.com:woytzek/final-project-drivers.git
DRIVERS_SITE_METHOD = git
DRIVERS_GIT_SUBMODULES = YES

DRIVERS_CFLAGS += 

define KERNEL_MODULE_BUILD_CMDS
    $(MAKE) -C '$(@D)' LINUX_DIR='$(LINUX_DIR)' CC='$(TARGET_CC)' LD='$(TARGET_LD)' modules
endef

DRIVERS_MODULE_SUBDIRS = gpio-rw

$(eval $(kernel-module))
$(eval $(generic-package))
