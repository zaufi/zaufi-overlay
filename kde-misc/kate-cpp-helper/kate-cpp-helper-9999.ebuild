# Copyright 2012-2013 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2
#
# kate: hl bash;

EAPI=5

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Kate C++ Helper plugin"
HOMEPAGE="http://zaufi.github.io/kate-cpp-helper-plugin.html"
# NOTE It is IMPORTANT to have this definition AFTER `inherit kde4-base`,
# cuz latter is a damn stupid and doesn't honor prior definition of EGIT_REPO_URI!
EGIT_REPO_URI="git://github.com/zaufi/kate-cpp-helper-plugin.git"

IUSE=""
LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"

DEPEND="
	$(add_kdeapps_dep kate)
	>=dev-lib/boost-1.62
	>=dev-lib/xapian-1.4.0
	>=sys-devel/clang-3.9"
RDEPEND="${DEPEND} >=sys-devel/gcc-4.9"
