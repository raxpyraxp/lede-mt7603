# MT7603 Driver Feed for LEDE

This is a driver from Asus Padavan firmwares adopted for LEDE and specifically TP-Link WR840N v4 and TP-Link WR841N v13. Some tools was taken from https://github.com/rssnsj/openwrt-hc5x61

# Builds

LEDE firmware builds for WR841Nv13 and WR840Nv4 with this driver are available here: https://raxp.ru/index.php/2017/06/21/lede-for-wr841n-v13wr840n-v4-en/

# Build your own firmware

- Clone LEDE repo from [here](https://github.com/lede-project/source.git)
- Add this line to the feeds.conf:
```src-git mt7603 https://github.com/worm202/lede-mt7603.git```
- Run **./scripts/feeds update**
- Run **./scripts/feeds install mt7603**
- Run **make menuconfig**, select:
-- Target: **MediaTek Ralink MIPS**
-- Subtarget: **MT7628 based boards**
-- Device: **TP-Link WR841N v13** or **TP-Link WR840N v4**
- Select:
-- MTK properties -> Applications -> **8021xd, uci2dat**
-- Ralink properties -> Drivers -> **kmod-foe-hook, kmod-mt7628, kmod-ralink-mtd**
- Unselect all Kernel -> Wireless Drivers -> **kmod-mt76xx**
- Select additional packages you need and build LEDE as normal with **make V=s -j4**
