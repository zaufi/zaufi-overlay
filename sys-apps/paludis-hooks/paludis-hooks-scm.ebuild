# Copyright 2011 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# kate: hl bash;

EAPI="4"

EHG_REPO_URI="http://bitbucket.org/zaufi/paludis-hooks"
inherit mercurial cmake-utils

DESCRIPTION="My hooks for paludis"
HOMEPAGE="http://bitbucket.org/zaufi/paludis-hooks"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

COMMON_DEPEND="sys-apps/paludis"

DEPEND="${COMMON_DEPEND} dev-util/cmake"
RDEPEND="${COMMON_DEPEND} dev-libs/libxslt"

src_unpack() {
    mercurial_src_unpack
}

src_install() {
    cmake-utils_src_install

    einfo "Installing hooks into paludis configuration dir..."

    # Create all necessary directories
    dodir ${PALUDIS_CONFIG_DIR}/hooks/ebuild_{compile_{post,pre},configure_{post,pre},install_{post,pre}}
    dodir /var/paludis/autopatches/ebuild_{compile_{post,pre},configure_{post,pre},install_pre}

    # Symlink hooks into configuration dirs
    local auto_patch="/usr/share/paludis/hooks/auto-patch.bash"
    local symlinks_maintainer="/usr/share/paludis/hooks/symlinks-maintainer.bash"
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_compile_pre
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_compile_post
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_configure_post
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_configure_pre
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_install_pre
    dosym ${symlinks_maintainer} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_install_post
}
