# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite"

MY_PV="a119004"
MY_P="${PN}-${MY_PV}"

inherit eutils multilib python-single-r1

DESCRIPTION="automatic updater and package installer/remover for rpm systems"
HOMEPAGE="http://yum.baseurl.org/"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"

RDEPEND="${PYTHON_DEPS}
	app-arch/rpm[python,${PYTHON_USEDEP}]
	dev-python/sqlitecachec[${PYTHON_USEDEP}]
	dev-libs/libxml2[python,${PYTHON_USEDEP}]
	dev-python/urlgrabber[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-util/intltool
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e 's/make/$(MAKE)/' Makefile || die
	sed -i -e "s:lib:$(get_libdir):g" rpmUtils/Makefile yum/Makefile || die
	# Some NLS files are broken! Cuz I use only en_US, I don't care about NLS at all!
	sed -i -e 's/docs po/docs/' Makefile || die
}

src_install() {
	emake DESTDIR="${ED}" install
	python_optimize "${D%/}$(python_get_sitedir)" "${ED%/}/usr/share/yum-cli"
	python_fix_shebang "${ED%}/usr/bin/yum"
	rm -r "${ED%/}/etc/rc.d" || die
}
