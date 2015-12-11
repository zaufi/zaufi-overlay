# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5


DESCRIPTION="Oracle, Odbc and DB2-CLI Template Library"
HOMEPAGE="http://otl.sourceforge.net/"
SRC_URI="http://otl.sourceforge.net/otlv4_h2.zip
    http://otl.sourceforge.net/otl4_htm.zip
    http://otl.sourceforge.net/otl4_examples.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples"

DEPEND=""
RDEPEND="${DEPEND}"

RESTRICT="mirror"

src_unpack() {
    mkdir -p ${S}
    cd ${S}
    default_src_unpack
}

src_install() {
    doheader otlv4.h
    # Check if docs are requested
    if use doc; then
        dohtml *.htm *.gif
    fi
}
