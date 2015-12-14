# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
#
# Initially this file was autogenerated by [npm2ebuild](https://github.com/zaufi/npm2ebuild)
#

EAPI=5

inherit npm

DESCRIPTION="ECMAScript parsing infrastructure for multipurpose analysis"
HOMEPAGE="http://esprima.org"

LICENSE="BSD-2-Clause"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=net-libs/nodejs-0.10.0"
RDEPEND="${DEPEND}
"

src_install() {
        npm_src_install

        exeinto "$(get_nodemoduledir)"/bin
        doexe ./bin/esparse.js
        dosym "$(get_nodemoduledir)"/./bin/esparse.js /usr/bin/esparse
        doexe ./bin/esvalidate.js
        dosym "$(get_nodemoduledir)"/./bin/esvalidate.js /usr/bin/esvalidate
}