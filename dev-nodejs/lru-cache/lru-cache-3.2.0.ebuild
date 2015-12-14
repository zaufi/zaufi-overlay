# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
#
# Initially this file was autogenerated by [npm2ebuild](https://github.com/zaufi/npm2ebuild)
#

EAPI=5

inherit npm

DESCRIPTION="A cache object that deletes the least-recently-used items."
HOMEPAGE="https://github.com/isaacs/node-lru-cache#readme"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=net-libs/nodejs-0.10"
RDEPEND="${DEPEND}
    =dev-nodejs/pseudomap-1.0.1
"