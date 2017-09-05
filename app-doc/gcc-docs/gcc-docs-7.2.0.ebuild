# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="GCC Documentton"
HOMEPAGE="https://gcc.gnu.org/onlinedocs/"
SRC_URI="https://gcc.gnu.org/onlinedocs/${P/-docs/}/gcc-html.tar.gz -> ${P}-html.tar.gz"
RESTRICT="mirror"

LICENSE=""
SLOT="7.2.0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

#src_unpack() {
#	mkdir -p "${S}"
#	cd "${S}"
#	default_src_unpack
#}

src_install() {
	cd gcc
	dohtml *
}
