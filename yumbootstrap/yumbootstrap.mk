########################
# YUMBOOTSTRAP
########################

# YUMBOOTSTRAP_VERSION = 1.0
YUMBOOTSTRAP_VERSION= master
YUMBOOTSTRAP_SITE=$(call github,dozzie,yumbootstrap,$(YUMBOOTSTRAP_VERSION))
YUMBOOTSTRAP_INSTALL_STAGING = YES
YUMBOOTSTRAP_INSTALL_TARGET = YES
YUMBOOTSTRAP_SETUP_TYPE = setuptools
$(eval $(python-package))

define YUMBOOTSTRAP_BUILD_CMDS
 $(MAKE) install-notmodule
endef
