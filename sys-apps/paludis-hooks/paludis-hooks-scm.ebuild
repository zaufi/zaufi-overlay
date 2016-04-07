# Copyright 2011 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4,3_5} )
EGIT_REPO_URI="https://github.com/zaufi/paludis-hooks.git"
# TODO It must be python-single-r1 because of paludis dependency which
# is a single nowadays...
inherit git-r3 cmake-utils python-single-r1

DESCRIPTION="My hooks for paludis"
HOMEPAGE="https://github.com/zaufi/paludis-hooks"

# TODO Introduce USE flags to select what to install?
# I think it covers all variants of installation
IUSE="+autopatch +fs-manager +workdir-tmpfs +package-env"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

COMMON_DEPEND="sys-apps/paludis[python,${PYTHON_USEDEP}]"

DEPEND="${COMMON_DEPEND} dev-util/cmake sys-apps/util-linux"
RDEPEND="${PYTHON_DEPS}
    ${COMMON_DEPEND}
    sys-apps/coreutils
    sys-apps/grep
    sys-apps/sed
    virtual/awk
    dev-libs/libxslt
    dev-libs/libxml2
  "

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with autopatch AUTOPATCH)
		$(cmake-utils_use_with fs-manager FS_MANAGER)
		$(cmake-utils_use_with package-env PACKAGE_ENV)
		$(cmake-utils_use_with workdir-tmpfs WORKDIR_TMPFS)
	)
	cmake-utils_src_configure
}

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

	if use autopatch; then
		local -r auto_patch="${EPREFIX}"/usr/share/${PN}/auto-patch.bash
		dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_compile_pre
		dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_compile_post
		dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_configure_post
		dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_configure_pre
		dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_install_pre
		dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_unpack_post
		dosym "${auto_patch}" "${PALUDIS_CONFIG_DIR}"/hooks/install_all_post
	fi

	if use fs-manager; then
		local -r filesystem_manager="${EPREFIX}"/usr/share/${PN}/filesystem-manager.bash
		dosym "${filesystem_manager}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_install_post
	fi

	if use workdir-tmpfs; then
		local -r workdir_tmpfs="${EPREFIX}"/usr/share/${PN}/workdir-tmpfs.bash
		dosym "${workdir_tmpfs}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_init_post
		dosym "${workdir_tmpfs}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_tidyup_post
		dosym "${workdir_tmpfs}" "${PALUDIS_CONFIG_DIR}"/hooks/ebuild_tidyup_pre
		dosym "${workdir_tmpfs}" "${PALUDIS_CONFIG_DIR}"/hooks/install_fail
	fi

	python_fix_shebang "${D}"/usr/libexec/cave/commands/print-ebuild-path
}

pkg_postinst() {
	if use workdir-tmpfs; then
		if ! mountpoint /dev/shm; then
			eerror ""
			eerror "There is no tmpfs mounted on /dev/shm on your system. That mountpoint is necessary for workdir-tmpfs extension's normal work."
			eerror "Or you can disable the extension by setting IN_MEMORY_BUILD_ENABLED=false in /etc/paludis/hooks/configs/workdir-tmpfs.conf."
			eerror "ATTENTION! You might not be able to resolve packages otherwise."
			eerror ""
		else if [[ -n "`/bin/mount | grep 'on /dev/shm .*noexec'`" ]]; then
			eerror ""
			eerror "tmpfs mounted on /dev/shm with noexec option. You need to switch the option and remount /dev/shm for workdir-tmpfs extension's normal work."
			eerror "Or you can disable the extension by setting IN_MEMORY_BUILD_ENABLED=false in /etc/paludis/hooks/configs/workdir-tmpfs.conf."
			eerror "ATTENTION! You might not be able to resolve packages otherwise."
			eerror ""
		fi
		fi
	fi
}
