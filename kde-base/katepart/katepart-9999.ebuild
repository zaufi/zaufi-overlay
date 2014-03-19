# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# ATTENTION This ebuild will not install any header files
# they are part of kdelibs nowadays, so if (unlikely) kate
# will get some new KTE class/interface this ebuild must be hacked!
# (Check history for prevous encarnations of katepart and kate ebuilds)

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kate"
KMMODULE="part"
KDE_OVERRIDE_MINIMAL="4.11.0"
EGIT_MIRROR=http://anongit.kde.org

inherit kde4-meta

DESCRIPTION="KDE Editor KPart"
HOMEPAGE+=" http://kate-editor.org/about-katepart/"
KEYWORDS="~amd64"
IUSE="debug"

RESTRICT="test"
# bug 392993

KMEXTRA="
	addons/ktexteditor
"
src_prepare() {
	kde4-meta_src_prepare
	epatch ${FILESDIR}/0001-Make-consistent-behaviour-of-wordNext.patch
}

src_configure() {
	local mycmakeargs=(
		"-DBUILD_KTEXTEDITOR=1"
	)

	kde4-meta_src_configure
}
