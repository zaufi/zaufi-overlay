# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Python library designed to ease the use of the JIRA REST API"
HOMEPAGE="http://jira.readthedocs.org/en/latest/"
SRC_URI="https://pypi.python.org/packages/source/j/${PN}/${P}.tar.gz http://readthedocs.org/projects/jira/downloads/htmlzip/latest/ -> ${PN}-doc-${PV}.zip"

LICENSE="BSD public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"
RESTRICT="mirror test"

PATCHES=( "${FILESDIR}/python31-dont-need-ordereddict.patch" )

# >=dev-libs/cryptlib-3.3.3[python,${PYTHON_USEDEP}]
DEPEND="
	>=dev-python/requests-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/requests-oauthlib-0.3.3[${PYTHON_USEDEP}]
	dev-python/requests-toolbelt[${PYTHON_USEDEP}]
	dev-python/tlslite[${PYTHON_USEDEP}]
	>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/ordereddict[${PYTHON_USEDEP}]' python{2_7})
	"
RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	use doc && dohtml -r "${WORKDIR}"/jira-latest/*
}
