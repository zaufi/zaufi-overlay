# Copyright 2011 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
EGIT_REPO_URI="https://github.com/zaufi/paludis-hooks.git"
# TODO It must be python-single-r1 because of paludis dependency which
# is a single nowadays...
inherit git-r3 cmake-utils python-single-r1

DESCRIPTION="My hooks for paludis"
HOMEPAGE="https://github.com/zaufi/paludis-hooks"

# TODO Introduce USE flags to select what to install?
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

COMMON_DEPEND="sys-apps/paludis[python,${PYTHON_USEDEP}]"

DEPEND="${COMMON_DEPEND} dev-util/cmake"
RDEPEND="${PYTHON_DEPS} ${COMMON_DEPEND} sys-apps/grep dev-libs/libxslt dev-libs/libxml2"

src_install() {
    cmake-utils_src_install

    # Rename non-versioned doc dir
    mv "${D}"/usr/share/doc/${PN} "${D}"/usr/share/doc/${P}

    einfo "Installing hooks into paludis configuration dir..."

    # Create all necessary directories
    keepdir "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_{compile,configure,init,install,tidyup,unpack}_{pre,post}
    keepdir "${PALUDIS_CONFIG_DIR}"/hooks/install_{all_post,fail}
    # Create 'empty' directories for autopatch hook
    keepdir "${EPREFIX}"/var/db/paludis/autopatches/ebuild_{compile_{post,pre},configure_{post,pre},install_pre,unpack_post}

    # Symlink hooks into configuration dirs
    local -r auto_patch="${EPREFIX}"/usr/share/${PN}/auto-patch.bash
    local -r config_cache_cleaner="${EPREFIX}"/usr/share/${PN}/config-cache-cleaner.bash
    local -r filesystem_manager="${EPREFIX}"/usr/share/${PN}/filesystem-manager.bash
    local -r workdir_tmpfs="${EPREFIX}"/usr/share/${PN}/workdir-tmpfs.bash
    dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_compile_pre
    dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_compile_post
    dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_configure_post
    dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_configure_pre
    dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_install_pre
    dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_unpack_post
    dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/install_all_post
    dosym "${config_cache_cleaner}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_configure_pre
    dosym "${config_cache_cleaner}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_configure_post
    dosym "${filesystem_manager}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_install_post
    dosym "${workdir_tmpfs}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_init_post
    dosym "${workdir_tmpfs}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_tidyup_post
    dosym "${workdir_tmpfs}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_tidyup_pre
    dosym "${workdir_tmpfs}" "${PALUDIS_CONFIG_DIR}"/hooks/install_fail
    python_fix_shebang "${D}"/usr/libexec/cave/commands/print-ebuild-path
}
