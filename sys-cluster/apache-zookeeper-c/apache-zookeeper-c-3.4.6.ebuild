# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils autotools-utils

MY_PN_RE='apache-(.*)-c'
MY_PN=`[[ ${PN} =~ ${MY_PN_RE} ]] && echo "${BASH_REMATCH[1]}"`
MY_P="${MY_PN}-${PV}"

DESCRIPTION="C client library for ZooKeeper."
HOMEPAGE="http://zookeeper.apache.org/"
SRC_URI="mirror://apache/${MY_PN}/${MY_P}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror binchecks"
IUSE="doc"

DEPEND="sys-devel/gcc
	doc? ( app-doc/doxygen )"
RDEPEND=""

S="${WORKDIR}/${MY_P}/src/c"

# Can't build out of source due incorrect files check in the `./configure`
# script and absolute inability to build sane doxygened docs...
AUTOTOOLS_IN_SOURCE_BUILD=1
AUTOTOOLS_PRUNE_LIBTOOL_FILES=all

src_compile() {
	autotools-utils_src_compile
	use doc && autotools-utils_src_compile doxygen-doc
}

src_install() {
	use doc && HTML_DOCS=("${BUILD_DIR}/docs/html/")
	autotools-utils_src_install
}
