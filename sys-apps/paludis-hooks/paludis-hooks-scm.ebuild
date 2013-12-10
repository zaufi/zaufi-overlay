# Copyright 2011 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

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
RDEPEND="${COMMON_DEPEND} dev-libs/libxslt dev-libs/libxml2"

src_unpack() {
    git-2_src_unpack
}

src_install() {
    cmake-utils_src_install

    einfo "Installing hooks into paludis configuration dir..."

    # Create all necessary directories
    keepdir ${PALUDIS_CONFIG_DIR}/hooks/ebuild_{compile_{post,pre},configure_{post,pre},install_{post,pre},unpack_post}
    keepdir ${PALUDIS_CONFIG_DIR}/hooks/install_all_post
    # Create 'empty' directories for autopatch hook
    keepdir ${EPREFIX}/var/db/paludis/autopatches/ebuild_{compile_{post,pre},configure_{post,pre},install_pre,unpack_post}

    # Symlink hooks into configuration dirs
    local auto_patch="${EPREFIX}/usr/share/paludis/hooks/auto-patch.bash"
    local filesystem_manager="${EPREFIX}/usr/share/paludis/hooks/filesystem-manager.bash"
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_compile_pre
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_compile_post
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_configure_post
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_configure_pre
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_install_pre
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_unpack_post
    dosym ${auto_patch} ${PALUDIS_CONFIG_DIR}/hooks/install_all_post
    dosym ${filesystem_manager} ${PALUDIS_CONFIG_DIR}/hooks/ebuild_install_post
}
