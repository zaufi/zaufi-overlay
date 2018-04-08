# Copyright 2018 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v3

EAPI="6"

EGIT_REPO_URI="https://github.com/zaufi/oh-my-konsole.git"
inherit git-r3

DESCRIPTION="Color schemes and some funny stuff for KDE konsole terminal"
HOMEPAGE="https://github.com/zaufi/oh-my-konsole"

IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="kde-apps/konsole"

src_install() {
    DESTDIR="${D}" "${WORKDIR}/${P}/install.sh" -s
}
