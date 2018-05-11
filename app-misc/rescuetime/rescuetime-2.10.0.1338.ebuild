# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker

DESCRIPTION="A service that provides the user with the knowledge of how they
spend thier time while on the computer"
HOMEPAGE="https://www.rescuetime.com/"
SRC_URI="https://www.rescuetime.com/installers/${PN}_current_amd64.deb"
RESTRICT="mirror"

LICENSE="RescueTime"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4"

S=${WORKDIR}

src_unpack() {
	unpack_deb ${A}
}
