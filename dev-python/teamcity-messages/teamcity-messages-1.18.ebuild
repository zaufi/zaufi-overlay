# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=(python2_7 python3_{2,3,4,5})
inherit distutils-r1

DESCRIPTION="Send test results to TeamCity continuous integration server from unittest, nose, py.test, twisted trial (Python 2.4+)"
HOMEPAGE="https://github.com/JetBrains/teamcity-messages"
SRC_URI="https://github.com/JetBrains/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
