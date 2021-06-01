################################################################################
#
# DPKG
#
################################################################################

DPKG_VERSION = 1.20.5
DPKG_SOURCE = DPKG-$(DPKG_VERSION).tar.bz2
DPKG_SITE = http://ftp.debian.org/releases/DPKG-$(DPKG_VERSION_MAJOR).x
DPKG_DEPENDENCIES = \
	host-pkgconf \
	$(if $(BR2_PACKAGE_BZIP2),bzip2) \
	$(if $(BR2_PACKAGE_ELFUTILS),elfutils) \
	file \
	popt \
	$(if $(BR2_PACKAGE_XZ),xz) \
	zlib \
	$(TARGET_NLS_DEPENDENCIES)
DPKG_LICENSE = GPL-2.0 or LGPL-2.0 (library only)
DPKG_LICENSE_FILES = COPYING

DPKG_CONF_OPTS = \
	--disable-python \
	--disable-rpath \
	--with-external-db \
	--with-gnu-ld \
	--without-hackingdocs \
	--without-lua

ifeq ($(BR2_PACKAGE_ACL),y)
DPKG_DEPENDENCIES += acl
DPKG_CONF_OPTS += --with-acl
else
DPKG_CONF_OPTS += --without-acl
endif

ifeq ($(BR2_PACKAGE_BERKELEYDB),y)
DPKG_DEPENDENCIES += berkeleydb
DPKG_CONF_OPTS += --enable-bdb
else
DPKG_CONF_OPTS += --disable-bdb
endif

ifeq ($(BR2_PACKAGE_DBUS),y)
DPKG_DEPENDENCIES += dbus
DPKG_CONF_OPTS += --enable-plugins
else
DPKG_CONF_OPTS += --disable-plugins
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
DPKG_DEPENDENCIES += libcap
DPKG_CONF_OPTS += --with-cap
else
DPKG_CONF_OPTS += --without-cap
endif

ifeq ($(BR2_PACKAGE_LIBGCRYPT),y)
DPKG_DEPENDENCIES += libgcrypt
DPKG_CONF_OPTS += --with-crypto=libgcrypt
else ifeq ($(BR2_PACKAGE_LIBNSS),y)
DPKG_DEPENDENCIES += libnss
DPKG_CONF_OPTS += --with-crypto=nss
DPKG_CFLAGS += -I$(STAGING_DIR)/usr/include/nss -I$(STAGING_DIR)/usr/include/nspr
else ifeq ($(BR2_PACKAGE_BEECRYPT),y)
DPKG_DEPENDENCIES += beecrypt
DPKG_CONF_OPTS += --with-crypto=beecrypt
DPKG_CFLAGS += -I$(STAGING_DIR)/usr/include/beecrypt
else
DPKG_DEPENDENCIES += openssl
DPKG_CONF_OPTS += --with-crypto=openssl
endif

ifeq ($(BR2_PACKAGE_GETTEXT_PROVIDES_LIBINTL),y)
DPKG_CONF_OPTS += --with-libintl-prefix=$(STAGING_DIR)/usr
else
DPKG_CONF_OPTS += --without-libintl-prefix
endif

ifeq ($(BR2_PACKAGE_LIBARCHIVE),y)
DPKG_DEPENDENCIES += libarchive
DPKG_CONF_OPTS += --with-archive
else
DPKG_CONF_OPTS += --without-archive
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
DPKG_DEPENDENCIES += libselinux
DPKG_CONF_OPTS += --with-selinux
else
DPKG_CONF_OPTS += --without-selinux
endif

ifeq ($(BR2_PACKAGE_SQLITE),y)
DPKG_DEPENDENCIES += sqlite
DPKG_CONF_OPTS += --enable-sqlite
else
DPKG_CONF_OPTS += --disable-sqlite
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
DPKG_DEPENDENCIES += zstd
DPKG_CONF_OPTS += --enable-zstd
else
DPKG_CONF_OPTS += --disable-zstd
endif

ifeq ($(BR2_TOOLCHAIN_HAS_OPENMP),y)
DPKG_CONF_OPTS += --enable-openmp
else
DPKG_CONF_OPTS += --disable-openmp
endif

# ac_cv_prog_cc_c99: DPKG uses non-standard GCC extensions (ex. `asm`).
DPKG_CONF_ENV = \
	ac_cv_prog_cc_c99='-std=gnu99' \
	CFLAGS="$(TARGET_CFLAGS) $(DPKG_CFLAGS)" \
	LIBS=$(TARGET_NLS_LIBS)

$(eval $(autotools-package))
