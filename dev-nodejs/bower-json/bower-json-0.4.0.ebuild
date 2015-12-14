# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit npm

DESCRIPTION="Read bower.json files with semantics, normalisation, defaults and validation."

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND=">=net-libs/nodejs-0.8.10
	>=dev-nodejs/deep-extend-0.4.0
	>=dev-nodejs/ext-name-3.0.0
	>=dev-nodejs/graceful-fs-3.0.0
	>=dev-nodejs/intersect-1.0.1
	${DEPEND}"
