# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Scalable Vector Graphics (SVG)"
HOMEPAGE="http://www.w3.org/TR/SVG11/"
SRC_URI="http://www.w3.org/TR/SVG11/REC-SVG11-20110816.zip"
RESTRICT="mirror"

LICENSE=""
SLOT="0"
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
