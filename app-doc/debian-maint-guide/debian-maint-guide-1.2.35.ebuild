# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit unpacker

DESCRIPTION="Debian New Maintainers' Guide"
HOMEPAGE="http://www.debian.org/doc/devel-manuals#maint-guide"
DEB_NAME="maint-guide"
SRC_URI="mirror://ubuntu/pool/universe/${DEB_NAME:0:1}/${DEB_NAME}/${DEB_NAME}_${PV}_all.deb"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	dohtml -r ${WORKDIR}/usr/share/doc/${DEB_NAME}/html/
	dodoc ${WORKDIR}/usr/share/doc/${DEB_NAME}/{changelog.gz,copyright,${DEB_NAME}.{en.txt.gz,en.pdf}}
}
