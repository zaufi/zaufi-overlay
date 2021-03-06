# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
KDE_HANDBOOK="optional"
KMNAME="kate"
KDE_OVERRIDE_MINIMAL="4.11.0"
PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4,3_5,3_6} )

inherit python-single-r1 kde4-meta

DESCRIPTION="Kate is an MDI texteditor."
HOMEPAGE="http://www.kde.org/applications/utilities/kate http://kate-editor.org"
KEYWORDS="~amd64"
IUSE="debug python"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	python? (
		${PYTHON_DEPS}
		$(add_kdeapps_dep pykde4 "${PYTHON_USEDEP}" 4.14.3-r1)
	)
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep katepart)
"

KMEXTRA="
	addons/kate
	addons/plasma
"

pkg_setup() {
	if use python; then
		python-single-r1_pkg_setup
	fi
	kde4-meta_pkg_setup
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build python pate)
	)

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version kde-base/kaddressbook:${SLOT}; then
		echo
		elog "File templates plugin requires kde-base/kaddressbook:${SLOT}."
		elog "Please install it if you plan to use this plugin."
		echo
	fi
}
