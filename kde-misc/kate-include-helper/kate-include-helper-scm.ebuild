# Copyright 2012 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# kate: hl bash;

EAPI="4"

KDE_SCM="git"
EGIT_REPO_URI="git://github.com/zaufi/kate-include-helper-plugin.git"
inherit kde4-base

DESCRIPTION="Kate Include Helper plugin"
HOMEPAGE="http://github.com/zaufi/kate-include-helper-plugin"

IUSE=""
LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"

DEPEND="$(add_kdebase_dep kate)"
RDEPEND="${DEPEND}"
