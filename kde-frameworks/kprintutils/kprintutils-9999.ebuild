# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Print dialogs"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	kde-frameworks/kparts
	kde-frameworks/kxmlgui
	kde-frameworks/ktextwidgets
"
DEPEND="${RDEPEND}"

DOCS=( README.md )
