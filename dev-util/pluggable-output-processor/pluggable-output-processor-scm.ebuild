#
# Copyright 2013, Alex Turbov <i.zaufi@gmail.com>
#
# Install `outproc` live
#

EAPI=5

EGIT_REPO_URI="https://github.com/zaufi/pluggable-output-processor.git"
# TODO Check for other Python versions
PYTHON_COMPAT=( python3_{2,3} )

inherit distutils-r1 git-2 python-utils-r1

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
    app-admin/eselect
  "
DEPEND="${RDEPEND}"
IUSE=""

python_install_all() {
    distutils-r1_python_install_all

    # NOTE Stupid Python's distutils do copy for symlinked files,
    # so lets recreate symlinks again after install...
    local pp_dir=$(python_get_sitedir)/outproc/pp
    local i
    for i in cc c++ g++; do
        rm ${D}/${pp_dir}/${i}.py
        dosym ${pp_dir}/gcc.py ${pp_dir}/${i}.py
    done

    dodoc README.md LICENSE

    # Install eselect module
    insinto /usr/share/eselect/modules
    doins contrib/outproc.eselect

    # Make a dir required for eselect
    keepdir /usr/$(get_libdir)/outproc/bin
}

pkg_postinst() {
    elog "To enable some command post-processing module on a per-user basis run:"
    elog "  eselect outproc enable --user <module>"
    elog
    elog "To enable it system-wide run:"
    elog "  eselect outproc enable <module>"
    elog
    elog "To get list of available modules:"
    elog "  eselect outproc list"
}
