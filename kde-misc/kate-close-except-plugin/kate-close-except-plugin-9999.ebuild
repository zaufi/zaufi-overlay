# Copyright 2012 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2
#
# kate: hl bash;

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Kate Close Except plugin"
HOMEPAGE="http://github.com/zaufi/kate-close-except-plugin"
# NOTE It is IMPORTANT to have this definition AFTER `inherit kde4-base`,
# cuz latter is a damn stupid and doesn't honor prior definition of EGIT_REPO_URI!
EGIT_REPO_URI="git://github.com/zaufi/kate-close-except-plugin.git"

IUSE=""
LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"

DEPEND="$(add_kdebase_dep kate)"
RDEPEND="${DEPEND}"
