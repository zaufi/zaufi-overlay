# Copyright 2011 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# kate: hl bash;

EAPI="4"

EGIT_REPO_URI="https://github.com/zaufi/paludis-hooks.git"
inherit git-2 cmake-utils

DESCRIPTION="My hooks for paludis"
HOMEPAGE="https://github.com/zaufi/paludis-hooks"

# TODO Introduce USE flags to select what to install?
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

COMMON_DEPEND="sys-apps/paludis"

DEPEND="${COMMON_DEPEND} dev-util/cmake"
RDEPEND="${COMMON_DEPEND} dev-libs/libxslt"

src_unpack() {
    git-2_src_unpack
}

src_install() {
    cmake-utils_src_install

    einfo "Installing hooks into paludis configuration dir..."

    # Create all necessary directories
    dodir ${PALUDIS_CONFIG_DIR}/hooks/ebuild_{compile_{post,pre},configure_{post,pre},install_{post,pre}}
    # Create 'empty' directories for autopatch hook
    dodir /var/paludis/autopatches/ebuild_{compile_{post,pre},configure_{post,pre},install_pre}
    touch ${D}/var/paludis/autopatches/ebuild_{compile_{post,pre},configure_{post,pre},install_pre}

    # Symlink hooks into configuration dirs
    local auto_patch="/usr/share/paludis/hooks/auto-patch.bash"
    local filesystem_manager="/usr/share/paludis/hooks/filesystem-manager.bash"
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_compile_pre
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_compile_post
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_configure_post
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_configure_pre
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_install_pre
    dosym ${filesystem_manager} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_install_post
}
