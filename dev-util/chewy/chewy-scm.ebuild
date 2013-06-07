#
# Copyright 2013, Alex Turbov <i.zaufi@gmail.com>
#
# Install `chewy` live
#

EAPI=5

EGIT_REPO_URI="https://github.com/mutanabbi/chewy.git"
# TODO Fix Python 3.3 support
# TODO Check for other Python versions
PYTHON_COMPAT=( python3_{2,3} )

inherit bash-completion-r1 distutils-r1 git-2

DESCRIPTION="CMake Helpers Easy Way sYnchronizer"
HOMEPAGE="https://github.com/mutanabbi/chewy"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
RDEPEND="${PYTHON_DEPS} sys-apps/portage[${PYTHON_USEDEP}] virtual/python-argparse[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
IUSE=""

python_install_all() {
    distutils-r1_python_install_all0
    dobashcomp bash_completion.d/${PN}
}
