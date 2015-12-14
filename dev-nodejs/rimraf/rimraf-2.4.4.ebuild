# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
#
# Initially this file was autogenerated by [npm2ebuild](https://github.com/zaufi/npm2ebuild)
#

EAPI=5

inherit npm

DESCRIPTION="A deep deletion module for node (like &#x60;rm -rf&#x60;)"
HOMEPAGE="https://github.com/isaacs/rimraf#readme"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=net-libs/nodejs-0.10"
RDEPEND="${DEPEND}
    =dev-nodejs/glob-5.0.14
"

src_install() {
        npm_src_install

        exeinto "$(get_nodemoduledir)"/bin
        doexe ./bin.js
        dosym "$(get_nodemoduledir)"/./bin.js /usr/bin/rimraf
}