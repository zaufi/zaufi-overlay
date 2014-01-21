#
# Copyright 2014, Ilya Kolesnikovich <ravishankar@mail.ru>
#

EAPI=5

EGIT_REPO_URI="https://github.com/peterhoeg/vim-qml.git"

inherit git-r3

DESCRIPTION="Syntax files to support qml in vim"
HOMEPAGE="https://github.com/peterhoeg/vim-qml"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_VIM_VERSION=7.3
DEPEND="|| ( >=app-editors/vim-${VIM_PLUGIN_VIM_VERSION}
	>=app-editors/gvim-${VIM_PLUGIN_VIM_VERSION} )"
RDEPEND="${DEPEND}"

src_install() {
	pushd "${WORKDIR}/${P}"
	insinto /usr/share/vim/vimfiles
	doins -r ftplugin
	doins -r ftdetect
	doins -r indent
	doins -r syntax
	popd
}
