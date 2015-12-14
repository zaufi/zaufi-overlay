# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
#
# Initially this file was autogenerated by [npm2ebuild](https://github.com/zaufi/npm2ebuild)
#

EAPI=5

inherit npm

DESCRIPTION="Get the name of the current operating system. Example: OS X Mavericks"
HOMEPAGE="https://github.com/sindresorhus/os-name"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=net-libs/nodejs-0.10.0"
RDEPEND="${DEPEND}
    =dev-nodejs/osx-release-1.0.0
    =dev-nodejs/win-release-1.0.0
"

src_install() {
        npm_src_install

        exeinto "$(get_nodemoduledir)"/bin
        doexe cli.js
        dosym "$(get_nodemoduledir)"/cli.js /usr/bin/os-name
}