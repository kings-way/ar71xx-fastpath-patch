## Intro
* SFE patches mainly from Qualcomm Open-Sourced Shortcut FE driver(SFE).
* Some modification on gwlim's patches for bugfix and simplicity.
* Works on LEDE 17.01 Trunk (For now the HEAD Commit: afca23558a2fbfb2cb044ec69bfb9a7447121927)
* 74kc CPU is able to run 24kc instruction. Feel free to compile 24kc target binary after applying SFE patches for 74kc CPU. (Build Config: CPU_TYPE)

## Build
### 1. Clone the code

	git clone -b lede-17.01 https://github.com/lede-project/source.git lede.bak
	git clone https://github.com/kings-way/ar71xx-fastpath-patch.git sfe_patch
	cp -r lede.bak lede

### 2. Apply the patch
* For MIPS 24kc:
	
		cd lede
		cp -r ../sfe_patch/patch_24kc/* ./
		./patch_SFE.sh


* For MIPS 74kc:

	
		cd lede
		cp -r ../sfe_patch/patch_74kc/* ./
		./patch_SFE.sh

### 3. Config & Compile
Make sure you choose these
> Kernel Modules > Network Support > kmod-fast-classifier

> Kernel Modules > Network Support > kmod-shortcut-fe or 

> Kernel Modules > Network Support > kmod-shortcut-fe-cm

> Kernel Modules > Wireless Drivers > kmod-owl-loader  ==> For nand device with Atheros PCI(e) Wifi chip

	make menuconfig
	
	make -j[XX]
	# make V=s -j1 with more verbose output for trouble shooting

## Refer
* The source of these patches

https://github.com/gwlim/mips24k-ar71xx-lede-patch

https://github.com/gwlim/mips74k-ar71xx-lede-patch

https://github.com/gwlim/mips24k-ar71xx-lede-patch/pull/13

https://github.com/gwlim/mips74k-ar71xx-lede-patch/pull/25


* Other helpful information

https://github.com/dissent1/sfe-src

https://github.com/openwrt-stuff/qca

https://github.com/lede-project/source/pull/1269

https://forum.lede-project.org/t/qualcomm-fast-path-for-lede/4582/602

https://lists.infradead.org/pipermail/lede-commits/2016-September/000816.html

