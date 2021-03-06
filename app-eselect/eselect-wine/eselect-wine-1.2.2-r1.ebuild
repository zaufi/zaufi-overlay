# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Manage active wine version"
HOMEPAGE="https://bitbucket.org/NP-Hardass/eselect-wine"
SRC_URI="https://bitbucket.org/NP-Hardass/${PN}/raw/v${PV}/wine.eselect -> wine.eselect-${PV}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="-* amd64 x86 ~x86-fbsd"
IUSE=""

RDEPEND="app-admin/eselect
	dev-util/desktop-file-utils
	!!app-emulation/wine:0"

S=${WORKDIR}

src_install() {
	keepdir /etc/eselect/wine

	insinto /usr/share/eselect/modules
	cp "${DISTDIR}"/wine.eselect-${PV} "${WORKDIR}"
	epatch "${FILESDIR}"/dont-link-man-and-include.patch
	newins "${WORKDIR}"/wine.eselect-${PV} wine.eselect
}

pkg_prerm() {
	# Avoid conflicts with wine[-multislot] installed later
	if [[ -z ${REPLACED_BY_VERSION} ]]; then
		elog "${PN} is being uninstalled, removing symlinks"
		eselect wine unset --all || die
	else
		einfo "${PN} is being updated/reinstalled, not modifying symlinks"
	fi
}
