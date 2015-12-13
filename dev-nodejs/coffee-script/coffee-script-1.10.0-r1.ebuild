# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit npm

DESCRIPTION="Unfancy JavaScript."

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc extras"

DEPEND=">=dev-nodejs/mkdirp-0.3.5
	>=net-libs/nodejs-0.8.10
	"
RDEPEND="${DEPEND}"

NPM_DOCS="LICENSE CNAME CONTRIBUTING.md"

src_install() {
	npm_src_install

	exeinto "$(get_nodemoduledir)"/bin
	doexe bin/cofee bin/cake
	dosym "$(get_nodemoduledir)"/bin/cofee /usr/bin/cofee
	dosym "$(get_nodemoduledir)"/bin/cake /usr/bin/cake

	if use extras; then
		dodoc -r extras
	fi
}
