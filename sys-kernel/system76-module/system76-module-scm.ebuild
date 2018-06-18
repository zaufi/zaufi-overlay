# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/pop-os/system76-dkms"
EGIT_COMMIT="4dca191"

inherit git-r3 linux-mod

DESCRIPTION="Kernel Module for System76"
HOMEPAGE="https://github.com/pop-os/system76-dkms"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""

S=${WORKDIR}

MODULE_NAMES="system76(system76)"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="CC=$(tc-getBUILD_CC) KERN_DIR=${KV_DIR} KERN_VER=${KV_FULL} O=${KV_OUT_DIR} V=1 KBUILD_VERBOSE=1"
}

src_install() {
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
