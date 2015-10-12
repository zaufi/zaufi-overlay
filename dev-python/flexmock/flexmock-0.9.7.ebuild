# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4,3_5} )
inherit distutils-r1

DESCRIPTION="Mock/Stub/Spy library for Python"
HOMEPAGE=" http://has207.github.com/flexmock"
SRC_URI="https://pypi.python.org/packages/source/f/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="BSD"
SLOT="0"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
