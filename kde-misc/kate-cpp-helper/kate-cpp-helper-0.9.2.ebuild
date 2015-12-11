# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit kde4-base

MY_PV=${PV}

DESCRIPTION="Kate C++ Helper plugin"
HOMEPAGE="http://zaufi.github.io/kate-cpp-helper-plugin.html"
SRC_URI="https://github.com/zaufi/kate-cpp-helper-plugin/archive/version-${MY_PV}.tar.gz"

IUSE=""
LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	$(add_kdebase_dep kate)
	>=sys-devel/clang-3.1"

DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.6"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/* ${S}
}
