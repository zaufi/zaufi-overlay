# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tlslite/tlslite-0.4.3-r1.ebuild,v 1.7 2015/04/08 08:05:26 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_4 )

inherit distutils-r1

DESCRIPTION="A utility belt for advanced users of python-requests"
HOMEPAGE="https://toolbelt.readthedocs.org"
SRC_URI="https://pypi.python.org/packages/source/r/${PN}/${P}.tar.gz"

LICENSE="BSD public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror test"

DEPEND="
	>=dev-python/requests-2.0.1[${PYTHON_USEDEP}]
	<=dev-python/requests-3.0.0[${PYTHON_USEDEP}]
	"
RDEPEND="${DEPEND}"
