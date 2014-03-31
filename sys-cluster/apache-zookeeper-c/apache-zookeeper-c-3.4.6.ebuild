# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils autotools

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
IUSE=""

DEPEND="sys-devel/gcc"
RDEPEND=""

S="${WORKDIR}/${MY_P}/src/c"
