# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tlslite/tlslite-0.4.3-r1.ebuild,v 1.7 2015/04/08 08:05:26 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_4 )

inherit distutils-r1

DESCRIPTION="Python library designed to ease the use of the JIRA REST API"
HOMEPAGE="http://jira.readthedocs.org/en/latest/"
SRC_URI="https://pypi.python.org/packages/source/j/${PN}/${P}.tar.gz"

LICENSE="BSD public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="fetch test"

# >=dev-libs/cryptlib-3.3.3[python,${PYTHON_USEDEP}]
DEPEND="
	>=dev-python/requests-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/requests-oauthlib-0.3.3[${PYTHON_USEDEP}]
	dev-python/requests-toolbelt[${PYTHON_USEDEP}]
	dev-python/tlslite[${PYTHON_USEDEP}]
	>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
	"
RDEPEND="${DEPEND}"
