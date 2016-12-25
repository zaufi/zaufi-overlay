# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit kde4-base

DESCRIPTION="Kate C++ Helper plugin"
HOMEPAGE="http://zaufi.github.io/kate-cpp-helper-plugin.html"
SRC_URI="https://github.com/zaufi/kate-cpp-helper-plugin/archive/version-${PV}.tar.gz -> ${P}.tar.gz"

IUSE=""
LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	$(add_kdeapps_dep kate)
	>=dev-libs/xapian-1.4.1
	>=dev-libs/boost-1.62
	>=sys-devel/clang-3.9"

DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.9"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/* ${S}
}
