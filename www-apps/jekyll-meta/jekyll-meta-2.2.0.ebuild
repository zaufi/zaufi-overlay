# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Meta package for jekyll"
HOMEPAGE="https://zaufi.github.io/#I-will-post-about-this-crap-later"

KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x64-macos"
IUSE=""

RDEPEND="
    www-apps/jekyll-${PV}
    www-apps/jekyll-watch
    www-apps/jekyll-gist
    www-apps/jekyll-paginate
"
