# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} pypy )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="HTTP library for human beings"
HOMEPAGE="http://python-requests.org/ https://pypi.python.org/pypi/requests"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="test"

# Requirements checklist: 
# https://github.com/kennethreitz/requests/blob/master/requirements.txt
RDEPEND="
	app-misc/ca-certificates
	>=dev-python/alabaster-0.7.7[${PYTHON_USEDEP}]
	>=dev-python/Babel-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/chardet-2.2.1[${PYTHON_USEDEP}]
	>=dev-python/decorator-4.0.9[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.12[${PYTHON_USEDEP}]
	>=dev-python/flask-0.10.1[${PYTHON_USEDEP}]
	>=dev-python/httpbin-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/itsdangerous-0.24[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.8[${PYTHON_USEDEP}]
	>=dev-python/py-1.4.31[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.1.1[${PYTHON_USEDEP}]
	>=dev-python/PySocks-1.5.6[${PYTHON_USEDEP}]
	>=dev-python/pytz-2015.7[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/snowballstemmer-1.2.1[${PYTHON_USEDEP}]
	>=dev-python/sphinx-1.3.5[${PYTHON_USEDEP}]
	>=dev-python/sphinx_rtd_theme-0.1.9[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		>=dev-python/pytest-2.8.1[${PYTHON_USEDEP}]
		>=dev-python/pytest-cov-2.2.1[${PYTHON_USEDEP}]
		>=dev-python/pytest-httpbin-0.2.0[${PYTHON_USEDEP}]
	)
	"
#		>=dev-python/pytest-mock-0.11.0[${PYTHON_USEDEP}]

# tests connect to various remote sites
RESTRICT="test"

PATCHES=(
	"${FILESDIR}"/${PN}-2.9.1-system-packages.patch
	"${FILESDIR}"/${PN}-2.5.0-system-cacerts.patch
)

python_prepare_all() {
	# use system chardet & urllib3
	rm -r requests/packages/{chardet,urllib3} || die

	distutils-r1_python_prepare_all
}

python_test() {
	py.test -v || die
}
