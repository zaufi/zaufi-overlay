# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="clang API documentation"
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
	ln -s cover.html index.html
}

src_install() {
	dohtml -r `ls`
}
