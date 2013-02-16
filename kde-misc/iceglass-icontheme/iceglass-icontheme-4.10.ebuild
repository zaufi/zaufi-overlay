# Copyright 2013 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2
#

EAPI="5"

inherit eutils

DESCRIPTION="IceGlass KDE icon theme"
HOMEPAGE="http://kde-look.org/content/show.php?content=121145"
SRC_URI="http://ompldr.org/vaDk5cg/Iceglass%20${PV}.tar.xz"

LICENSE="Idontknow"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc x86"

IUSE=""

src_prepare()
{
    epatch ${FILESDIR}/${PV}-fix-broken-line.patch
}

src_install()
{
    insinto /usr/share/icons
    doins -r "IceGlass 4.10"
}
