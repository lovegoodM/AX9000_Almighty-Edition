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

# 修复ksmbd编译出错
rm -rf package/kernel/ksmbd
svn co https://github.com/coolsnowwolf/lede/trunk/package/kernel/ksmbd $PACK_DIR/ksmbd

# 修复qca编译出错
rm -rf package/qca/nss/qca-ssdk package/qca/nss/qca-nss-dp
svn co https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/kernel/qca-ssdk $PACK_DIR/qca-ssdk
svn co https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/kernel/qca-nss-dp $PACK_DIR/qca-nss-dp

# 修复luci-base和luci-lib-ipkg文件重复
rm -rf feeds/luci/modules/luci-base/luasrc/model/*ipkg*

