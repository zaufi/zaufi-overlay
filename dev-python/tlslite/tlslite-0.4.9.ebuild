# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5} pypy )

inherit distutils-r1

DESCRIPTION="TLS Lite is a free python library that implements SSL 3.0 and TLS 1.0/1.1"
HOMEPAGE="http://trevp.net/tlslite/ http://pypi.python.org/pypi/tlslite"
SRC_URI="https://github.com/trevp/tlslite/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
#Refrain for now setting IUSE test and deps of test given test restricted.
IUSE="doc gmp"
RESTRICT="mirror test"

# >=dev-libs/cryptlib-3.3.3[python,${PYTHON_USEDEP}]
DEPEND="|| (
		dev-python/pycrypto[${PYTHON_USEDEP}]
		dev-python/m2crypto[${PYTHON_USEDEP}]
	)
	gmp? ( dev-python/gmpy[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}"

# Tests still hang
python_test() {
	"${S}"/tests/tlstest.py client localhost:4443 .
	"${S}"/tests/tlstest.py server localhost:4442 .
}

python_install_all(){
	distutils-r1_python_install_all
	use doc && dohtml -r docs/
}
