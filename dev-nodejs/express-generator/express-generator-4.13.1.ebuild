# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit npm

DESCRIPTION="Express' application generator"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=net-libs/nodejs-0.8.10
	=dev-nodejs/commander-2.7.1
	=dev-nodejs/mkdirp-0.5.1
	=dev-nodejs/sorted-object-1.0.0
	${DEPEND}"

NPM_EXTRA_FILES="templates"

src_install() {
	npm_src_install

	exeinto "$(get_nodemoduledir)"/bin
	doexe bin/express
	dosym "$(get_nodemoduledir)"/bin/express /usr/bin/express
}
