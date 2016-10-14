# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit unpacker

DESCRIPTION="Debian Policy Manual and related documents"
HOMEPAGE="https://www.debian.org/doc/devel-manuals#policy"
DEB_NAME="debian-policy"
SRC_URI="http://archive.ubuntu.com/ubuntu/pool/universe/${DEB_NAME:0:1}/${DEB_NAME}/${DEB_NAME}_${PV}_all.deb mirror://ubuntu/pool/universe/${DEB_NAME:0:1}/${DEB_NAME}/${DEB_NAME}_${PV}_all.deb"
RESTRICT="mirror"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	dohtml -r ${WORKDIR}/usr/share/doc/${DEB_NAME}/{menu-policy,perl-policy,policy,upgrading-checklist,copyright-format-1.0,debconf_specification,menu-policy-1,perl-policy,policy-1,Process,README}.html
	dohtml -r ${WORKDIR}/usr/share/doc/${DEB_NAME}/fhs

	dodoc ${WORKDIR}/usr/share/doc/${DEB_NAME}/{changelog.gz,copyright,{copyright-format-1.0,debconf_specification,libc6-migration,menu-policy,perl-policy,policy,Process,README,upgrading-checklist,virtual-package-names-list}.txt.gz}
	dodoc ${WORKDIR}/usr/share/doc/${DEB_NAME}/fhs/fhs-2.3.{txt.gz,pdf.gz,ps.gz}
}
