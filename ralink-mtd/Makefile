# All rights reserved.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=ralink-mtd
PKG_VERSION:=1.0
PKG_RELEASE:=20150605

PKG_SOURCE_VERSION:=1.0
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
#PKG_SOURCE_URL:=https://github.com/i80s/mtk-sources/releases/download/v1.0-vanilla
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2

PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_KCONFIG:= \
	MTD_RALINK

PKG_CONFIG_DEPENDS:=$(foreach c, $(PKG_KCONFIG),$(if $(CONFIG_$c),CONFIG_$(c)))

include $(INCLUDE_DIR)/package.mk

define KernelPackage/ralink-mtd
  CATEGORY:=Ralink Properties
  TITLE:=Ralink mtd driver
  FILES:=$(PKG_BUILD_DIR)/ralink-flash.ko
  SUBMENU:=Drivers
  AUTOLOAD:=$(call AutoLoad,81,ralink-flash)
  DEPENDS:=
  MENU:=1
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		ARCH="$(LINUX_KARCH)" \
		SUBDIRS="$(PKG_BUILD_DIR)/" \
		$(foreach c, $(PKG_KCONFIG),$(if $(CONFIG_$c),CONFIG_$(c)=$(CONFIG_$(c))))\
		CONFIG_SUPPORT_OPENWRT=y \
		modules
endef

$(eval $(call KernelPackage,ralink-mtd))
