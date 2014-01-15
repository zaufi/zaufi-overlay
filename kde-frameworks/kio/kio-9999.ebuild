# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Network transparent access to files and data"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="acl ssl"

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5
	dev-qt/qtscript:5
	dev-qt/qtxml:5
	dev-qt/qtwidgets:5
	kde-frameworks/karchive
	kde-frameworks/kbookmarks
	kde-frameworks/kcompletion
	kde-frameworks/kconfigwidgets
	kde-frameworks/kcoreaddons
	kde-frameworks/kcrash
	kde-frameworks/kdbusaddons
	kde-frameworks/kguiaddons
	kde-frameworks/ki18n
	kde-frameworks/kiconthemes
	kde-frameworks/kitemviews
	kde-frameworks/kjobwidgets
	kde-frameworks/knotifications
	kde-frameworks/kservice
	kde-frameworks/ktextwidgets
	kde-frameworks/kwidgetsaddons
	kde-frameworks/kwindowsystem
	kde-frameworks/kxmlgui
	kde-frameworks/solid
	sys-libs/zlib
	acl? ( virtual/acl )
	ssl? ( dev-libs/openssl )
"
DEPEND="${RDEPEND}"

DOCS=( README.md )
