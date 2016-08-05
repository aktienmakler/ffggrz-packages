# Copyright (C) 2016 Matthias Drobny <matthias at freifunk-gera-greiz.de>
# This is free software, licensed under the Apache 2.0 license.

include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-reporting
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(GLUONDIR)/include/package.mk

define Package/gluon-provisioning
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=Reporting
  DEPENDS:=+gluon-core
endef

define Package/gluon-reporting/description
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/gluon-reporting/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,gluon-reporting))
