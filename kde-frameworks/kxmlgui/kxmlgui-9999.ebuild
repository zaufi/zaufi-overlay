# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME=kxmlgui
VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Framework for managing menu and toolbar actions"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	kde-frameworks/kitemviews
	kde-frameworks/kconfig
	kde-frameworks/kglobalaccel
	kde-frameworks/kconfigwidgets
	kde-frameworks/ki18n
	kde-frameworks/kiconthemes
	kde-frameworks/ktextwidgets
	kde-frameworks/kwidgetsaddons
	kde-frameworks/kwindowsystem
"
DEPEND="${RDEPEND}"

DOCS=( README.md )
