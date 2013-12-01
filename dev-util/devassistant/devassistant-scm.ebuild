# Copyright 2013, Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# Install DevAssistant live
#

EAPI=5

EGIT_REPO_URI="https://github.com/bkabrda/devassistant.git"
# TODO Check for other Python versions
PYTHON_COMPAT=( python3_{2,3} )

inherit bash-completion-r1 distutils-r1 git-2

DESCRIPTION="DevAssistant: Making life easier for developers"
HOMEPAGE="http://devassistant.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND="${PYTHON_DEPS} dev-python/PyGithub[${PYTHON_USEDEP}] dev-python/pyyaml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
IUSE=""

PATCHES=( "${FILESDIR}"/00-do-not-install-gui.patch )

DOCS=( 'LICENSE' )

python_install_all() {
    distutils-r1_python_install_all
    newbashcomp da.bash da
    keepdir ${EPREFIX}/usr/share/devassistant/
}
