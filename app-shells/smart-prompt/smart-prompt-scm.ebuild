# Copyright 2013 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v3

EAPI="5"

EGIT_REPO_URI="https://github.com/zaufi/smart-prompt.git"
inherit git-2 cmake-utils

DESCRIPTION="Smart bash prompt: show various context info in a command prompt"
HOMEPAGE="https://github.com/zaufi/smart-prompt"

IUSE="git subversion"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

COMMON_DEPEND="apps-shells/bash"

DEPEND="${COMMON_DEPEND} dev-util/cmake"
RDEPEND="${COMMON_DEPEND}
    git? ( dev-vcs/git )
    subversion? ( dev-vcs/subversion )
    "

src_unpack() {
    git-2_src_unpack
}

src_configure() {
    local mycmakeargs=(
        $(cmake-utils_use_disable git)
        $(cmake-utils_use_disable svn)
    )
    cmake-utils_src_configure
}
