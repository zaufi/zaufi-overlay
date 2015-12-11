# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Cascading Style Sheets Level 2 Revision 1 (CSS 2.1) Specification"
HOMEPAGE="http://www.w3.org/TR/CSS2/"
SRC_URI="http://www.w3.org/TR/CSS2/css2.tgz"
RESTRICT="mirror"

LICENSE=""
SLOT="2.1"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	mkdir -p "${S}"
	cd "${S}"
	default_src_unpack
}

src_install() {
	dohtml -r `ls`
}
