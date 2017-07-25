#!/bin/sh
append DRIVERS "mt7628_ap"

. /lib/wifi/ralink_common.sh

prepare_mt7628_ap() {
	prepare_ralink_wifi mt7628_ap
}

scan_mt7628_ap() {
	scan_ralink_wifi ra0 mt7628_ap
}

disable_mt7628_ap() {
	disable_ralink_wifi mt7628_ap
}

enable_mt7628_ap() {
	enable_ralink_wifi ra0 mt7628_ap
}

detect_mt7628_ap() {
#	detect_ralink_wifi mt7628_ap mt7628_ap
	cd /sys/module
	[ -d $module ] || return
	uci get wireless.mt7628_ap >/dev/null 2>&1 && return
	ifconfig rai0 >/dev/null 2>&1 || return
	cat <<EOF > /etc/config/wireless
config wifi-device ra0
	option type mt7628_ap
	option vendor ralink
	option band 2.4G
	option channel 3
	option autoch 2

config wifi-iface
	option device ra0
	option ifname rai0
	option network lan
	option mode ap
	option ssid MT7628
	option encryption none

EOF

}

