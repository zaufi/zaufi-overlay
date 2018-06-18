# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/zaufi/system76-dkms"
EGIT_COMMIT="e8a821c"

inherit git-r3 linux-mod

DESCRIPTION="Kernel Module for System76"
HOMEPAGE="https://github.com/pop-os/system76-dkms"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""

S="${WORKDIR}/${P}"

MODULE_NAMES="system76(system76)"
BUILD_TARGETS="clean all"

src_install() {
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
