# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
KDE_DOXYGEN="true"
FRAMEWORKS_VERSION="5.3.0"
inherit kde5

DESCRIPTION="Framework providing a full text editor component"
LICENSE="LGPL-2+"
KEYWORDS="~amd64"
IUSE="git"

RDEPEND="
	$(add_frameworks_dep karchive "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep kcodecs "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep kcompletion "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep kconfig "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep kconfigwidgets "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep kcoreaddons "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep kguiaddons "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep ki18n "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep kiconthemes "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep kio "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep kitemviews "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep kjobwidgets "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep kparts "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep ktextwidgets "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep kwidgetsaddons "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep kxmlgui "" "${FRAMEWORKS_VERSION")
	$(add_frameworks_dep sonnet "" "${FRAMEWORKS_VERSION")
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtscript:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	git? ( dev-libs/libgit2 )
"
DEPEND="${RDEPEND}
	test? ( $(add_frameworks_dep kservice) )
"

RESTRICT="test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package git LibGit2)
	)

	kde5_src_configure
}
