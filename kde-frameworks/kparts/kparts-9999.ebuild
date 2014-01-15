# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Plugin framework for user interface components"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	dev-qt/qtxml:5
	dev-qt/qtwidgets:5
	kde-frameworks/kio
	kde-frameworks/kxmlgui
	kde-frameworks/ktextwidgets
	kde-frameworks/knotifications
"
DEPEND="${RDEPEND}"

DOCS=( README.md )
