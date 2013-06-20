# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kate"
KMMODULE="part"
KMEXTRA="ktexteditor"
KDE_OVERRIDE_MINIMAL="4.10.4"
inherit kde4-meta

DESCRIPTION="KDE Editor KPart"
KEYWORDS="~amd64"
IUSE="debug"

RESTRICT="test"
# bug 392993

add_blocker kdelibs 4.6.50

src_prepare() {
	kde4-meta_src_prepare
	epatch ${FILESDIR}/0001-Make-consistent-behaviour-of-wordNext.patch
}

src_configure() {
	local mycmakeargs=(
		"-DKDE4_BUILD_TESTS=OFF"
		"-DBUILD_KTEXTEDITOR=ON"
	  )
	kde4-meta_src_configure
}
