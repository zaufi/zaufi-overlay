# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
DESCRIPTION="GnuPG keys of the Ubuntu archive"
HOMEPAGE="http://www.ubuntu.com/"
SRC_URI="mirror://ubuntu/pool/main/u/ubuntu-keyring/${PF}_${PV}_all.deb"

RESTRICT=""

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dodoc -r `ls ${P}/usr/share/doc/ununtu-keyring/*`
	insinto /usr/share/keyrings
	doins `ls ${P}/usr/share/keyrings/*`
}
