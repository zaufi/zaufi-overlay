# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 python-utils-r1

DESCRIPTION="Python module for downloading files"
HOMEPAGE="http://urlgrabber.baseurl.org"
SRC_URI="http://urlgrabber.baseurl.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-python/pycurl[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
# Entire testsuite relies on connecting to the i'net

python_prepare_all() {
        local PATCHES=(
                "${FILESDIR}"/${P}-fix-import.patch
        )
        #python_fix_shebang "${WORKDIR}/scripts"
        distutils-r1_python_prepare_all
}

