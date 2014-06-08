# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/urlgrabber/urlgrabber-3.10.1.ebuild,v 1.1 2014/05/21 02:46:06 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_2 python3_3 python3_4 )

inherit distutils-r1

DESCRIPTION="Python module for downloading files"
HOMEPAGE="http://urlgrabber.baseurl.org"
SRC_URI="http://urlgrabber.baseurl.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-python/pycurl[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/${P}-python3-fixes.patch"

src_install() 
{
    distutils-r1_src_install
    python_scriptinto /usr/libexec
    libexec_script_install() {
        python_fix_shebang "${S}/scripts/urlgrabber-ext-down"
        python_doexe "${S}/scripts/urlgrabber-ext-down"
    }
    python_foreach_impl libexec_script_install
}

# Entire testsuite relies on connecting to the i'net