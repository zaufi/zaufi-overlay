# Copyright 2013 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2
#

EAPI=5

inherit eutils

DESCRIPTION="IceGlass KDE icon theme"
HOMEPAGE="http://kde-look.org/content/show.php?content=121145"
SRC_URI="http://ompldr.org/vaDk5cg/Iceglass%20${PV}.tar.xz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc x86"

IUSE=""

src_unpack()
{
    mkdir -p ${S}
    cd ${S}
    default_src_unpack
}

src_prepare()
{
    epatch ${FILESDIR}/${PV}-fix-broken-line.patch
}

src_install()
{
    einfo "Going to install a lot of icons into ${S}... "
    einfo "Please be patient or buy SSD, or 15k rpm Ultra-640 SCSI, or ... ;-)"
    insinto /usr/share/icons
    doins -r "Iceglass ${PV}" || die "doins failed"
}
