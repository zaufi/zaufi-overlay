# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="HTML 4.01 Specification"
HOMEPAGE="http://www.w3.org/TR/html401/"
SRC_URI="http://www.w3.org/TR/html401/html40.tgz"
RESTRICT="mirror"

LICENSE=""
SLOT="4"
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
