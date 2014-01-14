# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Bookmark management"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	kde-frameworks/kconfigwidgets
	kde-frameworks/kcoreaddons
	kde-frameworks/kiconthemes
	kde-frameworks/kwidgetsaddons
	kde-frameworks/kxmlgui
"
DEPEND="${RDEPEND}"

DOCS=( README.md )
