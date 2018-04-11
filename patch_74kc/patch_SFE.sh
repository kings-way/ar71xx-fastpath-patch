#!/bin/bash
set -e
echo Add QCA Repo
wget https://source.codeaurora.org/quic/qsdk/oss/system/openwrt/plain/include/local-development.mk -P ./include/
sed -i 's|git describe --dirty|git describe|g' ./include/local-development.mk
sed -i 's|$(TOPDIR)/qca/src/$(PKG_NAME)|$(TOPDIR)/package/qca/$(PKG_NAME)/src|g' ./include/local-development.mk
echo 'src-git shortcutfe https://source.codeaurora.org/quic/qsdk/oss/system/feeds/shortcut-fe.git;release/endive_mips' >> ./feeds.conf.default
./scripts/feeds update -a
mkdir -p ./package/qca/
mv ./feeds/shortcutfe/* ./package/qca
# Delete the last 2 lines of feed conf because Repositories DO NOT EXIST
sed -i '$d' feeds.conf.default
sed -i '$d' feeds.conf.default
./scripts/feeds install -a
echo Remove Support for PPPOA
rm ./feeds/luci/protocols/luci-proto-ppp/luasrc/model/cbi/admin_network/proto_pppoa.lua
echo Remove AICCU Obsolete
rm ./feeds/luci/protocols/luci-proto-ipv6/luasrc/model/network/proto_aiccu.lua
rm ./feeds/luci/protocols/luci-proto-ipv6/luasrc/model/cbi/admin_network/proto_aiccu.lua
echo Remove Support for DIR-825 and AllNet Devices
rm ./target/linux/ar71xx/base-files/lib/upgrade/dir825.sh
rm ./target/linux/ar71xx/base-files/lib/upgrade/allnet.sh
        for i in $( ls patch ); do
            echo Applying patch $i
            patch -p1 < patch/$i
        done
make defconfig
rm .config
make defconfig
