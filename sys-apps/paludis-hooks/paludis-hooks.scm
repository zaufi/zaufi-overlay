# Copyright 2011 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# kate: hl bash;

EAPI="paludis-1"

EHG_REPO_URI="http://bitbucket.org/zaufi/paludis-hooks"
inherit mercurial cmake_utils

DESCRIPTION="My hooks for paludis"
HOMEPAGE="http://bitbucket.org/zaufi/paludis-hooks"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

COMMON_DEPEND="sys-apps/paludis"

DEPEND="${COMMON_DEPEND} dev-util/cmake"
RDEPEND="${COMMON_DEPEND} dev-libs/libxslt"
