# Copyright 2013 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2
#

EAPI=5

inherit eutils

DESCRIPTION="IceGlass KDE icon theme"
HOMEPAGE="http://kde-look.org/content/show.php?content=121145"
SRC_URI="Iceglass-4.10.1.tar.xz"
RESTRICT="fetch"

LICENSE="GPL"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc x86"

IUSE=""

pkg_nofetch()
{
    eerror "Manual fetch required form ${HOMEPAGE}"
    eerror "Then move ${SRC_URI} to ${DISTDIR}"
}

src_unpack()
{
    mkdir -p ${S}
    cd ${S}
    default_src_unpack
}

src_install()
{
    einfo "Going to install a lot of icons into ${S}... "
    einfo "Please be patient or buy SSD, or 15k rpm Ultra-640 SCSI, or ... ;-)"
    insinto /usr/share/icons
    doins -r "Iceglass-${PV}" || die "doins failed"
}
