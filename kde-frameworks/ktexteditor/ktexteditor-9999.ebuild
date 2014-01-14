# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Full text editor component"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtwidgets:5
	dev-qt/qtscript:5
	kde-frameworks/karchive
	kde-frameworks/kconfig
	kde-frameworks/kguiaddons
	kde-frameworks/ki18n
	kde-frameworks/kjobwidgets
	kde-frameworks/kio
	kde-frameworks/kparts
	kde-frameworks/kprintutils
	kde-frameworks/sonnet
	kde-frameworks/kxmlgui
	kde-frameworks/knotifications
"
DEPEND="${RDEPEND}"

DOCS=( README.md )
