# Copyright 2013, Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# Install DevAssistant live
#

EAPI=5

EGIT_REPO_URI="https://github.com/zaufi/devassistant.git"
# TODO Check for other Python versions
PYTHON_COMPAT=( python2_6 python2_7 python3_3 )

inherit bash-completion-r1 distutils-r1 git-2

DESCRIPTION="DevAssistant: Making life easier for developers"
HOMEPAGE="http://devassistant.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="${PYTHON_DEPS}
        dev-python/PyGithub[${PYTHON_USEDEP}]
        dev-python/pyyaml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
        doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/00-${P}-no-gui-install.patch )

DOCS=( 'CHANGELOG' 'LICENSE' 'README.rst' )


python_compile_all() {
    if use doc; then
        "${PYTHON}" setup.py build_sphinx || die
    fi
}

python_install_all() {
    # Install user and developers documentation
    # TODO Make it mandatory?
    use doc && local HTML_DOCS=( ${BUILD_DIR}/sphinx/html/. )

    distutils-r1_python_install_all

    newbashcomp da.bash da
    newbashcomp da.bash devassistant
    keepdir ${EPREFIX}/usr/share/devassistant/
}
