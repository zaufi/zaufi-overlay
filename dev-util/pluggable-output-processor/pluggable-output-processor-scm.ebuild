#
# Copyright 2013, Alex Turbov <i.zaufi@gmail.com>
#
# Install `outproc` live
#

EAPI=5

EGIT_REPO_URI="https://github.com/zaufi/pluggable-output-processor.git"
# TODO Check for other Python versions
PYTHON_COMPAT=( python3_{2,3} )

inherit distutils-r1 git-2

DESCRIPTION="Pluggable Output Processor"
HOMEPAGE="https://github.com/zaufi/pluggable-output-processor"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND="
    ${PYTHON_DEPS}
    sys-apps/portage[python3]
    virtual/python-argparse[${PYTHON_USEDEP}]
    dev-python/termcolor[${PYTHON_USEDEP}]
  "
DEPEND="${RDEPEND}"
IUSE=""
