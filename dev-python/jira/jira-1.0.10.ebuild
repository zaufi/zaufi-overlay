# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=(python2_7 python3_{2,3,4,5,6})
inherit distutils-r1

DESCRIPTION="Python library for interacting with the JIRA REST API"
HOMEPAGE="http://jira.readthedocs.io/en/latest/"
#SRC_URI="https://github.com/pycontribs/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://pypi.python.org/packages/f5/d3/2301c6ada2360119b8e99187979f488e3a5b203c122dd168c9fdb2e33394/${P}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="filemagic ipython oauth"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	filemagic? ( dev-python/filemagic[${PYTHON_USEDEP}] )
	ipython? ( dev-python/ipython[${PYTHON_USEDEP}] )
	oauth? (
		dev-python/requests-oauthlib[${PYTHON_USEDEP}]
		dev-python/tlslite[${PYTHON_USEDEP}]
		dev-python/pycrypto[${PYTHON_USEDEP}]
	)
	>=dev-python/requests-2.10.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/tlslite-0.4.4[${PYTHON_USEDEP}]
	dev-python/requests-toolbelt[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/pbr[${PYTHON_USEDEP}]
	"
