# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

DESCRIPTION="Open-source version of the fonts by Russian standard GOST 2.304-81 Letters for drawings"
HOMEPAGE="https://bitbucket.org/fat_angel/opengostfont"
SRC_URI="http://cdn.bitbucket.org/fat_angel/${PN}/downloads/${PN}-ttf-${PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${PN}-ttf-${PV}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
