# Copyright 2013 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v3

EAPI="5"

EGIT_REPO_URI="https://github.com/zaufi/smart-prompt.git"
inherit git-r3 cmake-utils

DESCRIPTION="Fancy bash prompt and some more stuff"
HOMEPAGE="https://github.com/zaufi/smart-prompt"

IUSE="docker git openrc paludis portage schroot subversion"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

COMMON_DEPEND=">=app-shells/bash-4.0"

DEPEND="${COMMON_DEPEND} dev-util/cmake"
RDEPEND="${COMMON_DEPEND}
    dev-util/dialog
    docker? ( app-emulation/docker )
    git? ( dev-vcs/git )
    paudis? ( sys-apps/paludis )
    portage? ( sys-apps/portage )
    schroot? ( dev-util/schroot )
    subversion? ( dev-vcs/subversion )
    "

src_configure() {
    local mycmakeargs=(
        $(cmake-utils_use_with docker)
        $(cmake-utils_use_with git)
        $(cmake-utils_use_with openrc)
        $(cmake-utils_use_with paludis)
        $(cmake-utils_use_with portage)
        $(cmake-utils_use_with schroot)
        $(cmake-utils_use_with subversion SVN)
    )
    cmake-utils_src_configure
}
