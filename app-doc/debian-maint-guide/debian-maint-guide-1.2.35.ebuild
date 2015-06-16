# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Debian New Maintainers' Guide"
HOMEPAGE="http://www.debian.org/doc/devel-manuals#maint-guide"
SRC_URI="mirror://ubuntu/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	dohtml -r ${S}/usr/share/doc/maint-guide/html/
}
