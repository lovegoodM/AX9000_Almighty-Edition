#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

LUCI_DIR='package/mj'
PACK_DIR='package/mj'
ln -s ../feeds/luci/luci.mk package/luci.mk

# Modify default IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改连接数
#sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=165535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
#修正连接数（by ベ七秒鱼ベ）
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# themes添加
git clone --depth=1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git $LUCI_DIR/luci-theme-infinityfreedom
git clone --depth=1 https://github.com/Leo-Jo-My/luci-theme-opentomcat.git $LUCI_DIR/luci-theme-opentomcat
git clone --depth=1 https://github.com/openwrt-develop/luci-theme-atmaterial.git $LUCI_DIR/luci-theme-atmaterial
# luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git $LUCI_DIR/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config $LUCI_DIR/luci-app-argon-config

#git clone --depth=1 https://github.com/kiddin9/openwrt-packages.git package/openwrt-packages

git clone --depth=1 https://github.com/sirpdboy/luci-app-netdata.git $LUCI_DIR/luci-app-netdata

# 添加额外非必须软件包
git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome.git $LUCI_DIR/luci-app-adguardhome
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash $LUCI_DIR/luci-app-openclash
#git clone --depth=1 https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone --depth=1 https://github.com/zzsj0928/luci-app-pushbot.git $LUCI_DIR/luci-app-pushbot
git clone --depth=1 https://github.com/riverscn/openwrt-iptvhelper.git $LUCI_DIR/openwrt-iptvhelper
#git clone --depth=1 https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
git clone --depth=1 https://github.com/kiddin9/luci-app-dnsfilter.git $LUCI_DIR/luci-app-dnsfilter
# 添加smartdns
rm -rf feeds/luci/applications/luci-app-smartdns
git clone --depth=1 https://github.com/pymumu/openwrt-smartdns $PACK_DIR/smartdns
git clone --depth=1 -b lede https://github.com/pymumu/luci-app-smartdns $LUCI_DIR/luci-app-smartdns
# 网络共享
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-cifsd $LUCI_DIR/luci-app-cifsd
# aliyundrive-webdav
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-aliyundrive-webdav $LUCI_DIR/luci-app-aliyundrive-webdav
svn co https://github.com/coolsnowwolf/packages/trunk/multimedia/aliyundrive-webdav $PACK_DIR/aliyundrive-webdav

# 更改Meson version
sed -i -r "s/(PKG_VERSION:=).*/\10.61.5/" tools/meson/Makefile
