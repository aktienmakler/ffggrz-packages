# Copyright (C) 2016 Matthias Drobny <matthias at freifunk-gera-greiz.de>
# This is free software, licensed under the Apache 2.0 license.

include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-provisioning
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(GLUONDIR)/include/package.mk

define Package/gluon-provisioning
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=Provisioning
  DEPENDS:=+gluon-core
endef

define Package/gluon-provisioning/description
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/gluon-provisioning/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,gluon-provisioning))
