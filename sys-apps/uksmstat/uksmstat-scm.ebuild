# Copyright 2011 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# kate: hl bash;

EAPI="5"

EGIT_REPO_URI="https://github.com/pfactum/uksmstat.git"
inherit git-2

DESCRIPTION="Small set of tools to control UKSM"
HOMEPAGE="https://github.com/pfactum/uksmstat"

IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""

src_unpack() {
    git-2_src_unpack
}

pkg_pretend() {
    if [ ! -d /sys/kernel/mm/uksm ]; then
        ewarn "This tool have sense only for kernels w/ UKSM patch applied (like pf-sources)"
    fi
}

src_install() {
    dobin uksmstat/uksmstat
    dosbin uksmctl/uksmctl
    dodoc README.md
    dodoc COPYING
}
