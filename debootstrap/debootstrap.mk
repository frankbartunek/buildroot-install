########################
# DEBOOTSTRAP
########################

# DEBOOTSTRAP_VERSION = 1.0
DEBOOTSTRAP_VERSION=master
DEBOOTSTRAP_SITE=$(call salsa.debian.org,installer-team,debootstrap,$(DEBOOTSTRAP_VERSION))
DEBOOTSTRAP_INSTALL_STAGING = YES
DEBOOTSTRAP_INSTALL_TARGET = YES
# DEBOOTSTRAP_DEPENDENCIES 
$(eval $(autotools-package))

define DEBOOTSTRAP_BUILD_CMDS
 $(MAKE) all
endef
