# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=(python2_7 python3_{2,3,4,5})
inherit distutils-r1

DESCRIPTION="Python library for interacting with the JIRA REST API"
HOMEPAGE="http://jira.readthedocs.io/en/latest/"
#SRC_URI="https://github.com/pycontribs/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://pypi.python.org/packages/4e/36/4f0ab121c3510fce29743c31e2f47e99c2be68ee4441ad395366489351b0/${P}.tar.gz"

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
	"
