# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python{2_7,3_{2,3,4,5}})

inherit eutils distutils-r1

DESCRIPTION="A Python client for Artifactory"
HOMEPAGE="https://github.com/Parallels/artifactory"
SRC_URI="https://github.com/Parallels/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DOCS="README.md"

RDEPEND="
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/pathlib[${PYTHON_USEDEP}]' python2_7 python3_2 python3_3 )
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

PATCHES=( "${FILESDIR}"/0001-pathlib-is-a-part-of-Python-since-3.4.patch )
