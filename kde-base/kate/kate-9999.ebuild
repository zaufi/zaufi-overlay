# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
KDE_HANDBOOK="optional"
KMNAME="kate"
KMEXTRA="addons/kate"
KDE_OVERRIDE_MINIMAL="4.10.4"
PYTHON_COMPAT=( python{2_7,3_1,3_2,3_3} )

inherit python-single-r1 kde4-meta

DESCRIPTION="Kate is an MDI texteditor."
KEYWORDS="~amd64"
IUSE="debug +plasma +python"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	python? (
		${PYTHON_DEPEND}
		$(add_kdebase_dep pykde4 "${PYTHON_USEDEP}" 4.9.2-r1)
	)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep katepart)
"

pkg_setup() {
	if use python; then
		python-single-r1_pkg_setup
	fi
	kde4-meta_pkg_setup
}

src_unpack() {
	if use plasma; then
		KMEXTRA="${KMEXTRA} addons/plasma"
	fi

	kde4-meta_src_unpack
}

src_prepare() {
	kde4-meta_src_prepare
	epatch ${FILESDIR}/build-without-kpart.patch
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build python pate)
		$(cmake-utils_use_with plasma)
	)

	kde4-meta_src_configure
}
