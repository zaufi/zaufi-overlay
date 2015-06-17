# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit unpacker

DESCRIPTION="Guidelines and information for Debian developers"
HOMEPAGE="https://www.debian.org/doc/devel-manuals#devref"
DEB_NAME="developers-reference"
SRC_URI="http://archive.ubuntu.com/ubuntu/pool/universe/${DEB_NAME:0:1}/${DEB_NAME}/${DEB_NAME}_${PV}_all.deb mirror://ubuntu/pool/universe/${DEB_NAME:0:1}/${DEB_NAME}/${DEB_NAME}_${PV}_all.deb"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	dohtml -r ${WORKDIR}/usr/share/doc/${DEB_NAME}/{apa,index,ch0{1,2,3,4,5,6,7,8}}.html

	dodoc ${WORKDIR}/usr/share/doc/${DEB_NAME}/{changelog.gz,copyright,${DEB_NAME}.{txt.gz,pdf}}
}
