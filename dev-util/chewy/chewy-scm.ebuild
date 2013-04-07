#
# Copyright 2013, Alex Turbov <i.zaufi@gmail.com>
#
# Install `chewy` live
#

EAPI=5

EGIT_REPO_URI="https://github.com/mutanabbi/chewy.git"
# TODO Check for other Python versions
PYTHON_COMPAT=( python3_2 )

inherit git-2 distutils-r1

DESCRIPTION="CMake Helpers Easy Way sYnchronizer"
HOMEPAGE="https://github.com/mutanabbi/chewy"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"
IUSE=""
