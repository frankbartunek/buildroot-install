########################
# Kilo
########################

# KILO_VERSION = 1.0
KILO_VERSION= master
KILO_SITE=$(call github,frankbartunek,kilo,$(KILO_VERSION))
KILO_INSTALL_STAGING = YES
KILO_INSTALL_TARGET = YES
$(eval $(autotools-package))

define KILO_BUILD_CMDS
 $(MAKE) all
endef
