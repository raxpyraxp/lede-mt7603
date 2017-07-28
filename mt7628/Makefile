# All rights reserved.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=mt7628
PKG_REV:=5
PKG_TYPE:=p4rev
PKG_FIX:=110971
PKG_VERSION:=$(PKG_TYPE)-$(PKG_FIX)
PKG_RELEASE:=20150605

PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
#PKG_SOURCE_URL:=https://github.com/i80s/mtk-sources/releases/download/v1.0-vanilla
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2

PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_KCONFIG:= \
	MT7628_AP MT7628_AP_LED MT7628_AP_LED_SOFT MT7628_AP_LED_SOFT_GPIO MT7628_AP_LLTD \
	MT7628_AP_WDS MT7628_AP_MBSS MT7628_AP_APCLI MT7628_AP_MULTI_APCLI MT7628_AP_MAC_REPEATER \
	MT7628_AP_AIRPLAY MT7628_AP_DFS MT7628_AP_CARRIER MT7628_AP_GREENAP MT7628_AP_IDS \
	MT7628_AP_DLS

PKG_CONFIG_DEPENDS:=$(foreach c, $(PKG_KCONFIG),$(if $(CONFIG_$c),CONFIG_$(c)))

include $(INCLUDE_DIR)/package.mk

define KernelPackage/mt7628
  CATEGORY:=Ralink Properties
  TITLE:=Ralink mt7628 wifi AP driver
  FILES:=$(PKG_BUILD_DIR)/mt7628_ap/mt7628_ap.ko
  AUTOLOAD:=$(call AutoLoad,91,mt7628_ap)
  SUBMENU:=Drivers
  DEPENDS:=+uci2dat +8021xd +kmod-foe-hook +kmod-ralink-mtd
  MENU:=1
endef

define KernelPackage/mt7628/config
	source "$(SOURCE)/config.in"
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		ARCH="$(LINUX_KARCH)" \
		SUBDIRS="$(PKG_BUILD_DIR)/mt7628_ap" \
		$(foreach c, $(PKG_KCONFIG),$(if $(CONFIG_$c),CONFIG_$(c)=$(CONFIG_$(c))))\
		CONFIG_SUPPORT_OPENWRT=y \
		modules
endef

define KernelPackage/mt7628/install
	$(INSTALL_DIR) $(1)/lib/wifi/
	$(INSTALL_BIN) ./files/mt7603.sh ./files/ralink_common.sh $(1)/lib/wifi/
	$(INSTALL_DIR) $(1)/etc/wireless/mt7628_ap/
	$(INSTALL_BIN) ./files/RT2860AP.dat $(1)/etc/wireless/mt7628_ap/
	$(INSTALL_DIR) $(1)/etc/wireless/mt7603e/
	#$(INSTALL_BIN) ./files/mt7603.dat $(1)/etc/wireless/mt7603/
	$(INSTALL_BIN) ./files/MT7628_EEPROM.bin $(1)/etc/wireless/mt7603e/
	$(INSTALL_DIR) $(1)/etc/uci-defaults/
	$(INSTALL_BIN) ./files/10_mt7628_autostart.sh $(1)/etc/uci-defaults/
	echo p$(P4REV) > $(1)/etc/wireless/mt7603e/version
endef

$(eval $(call KernelPackage,mt7628))
