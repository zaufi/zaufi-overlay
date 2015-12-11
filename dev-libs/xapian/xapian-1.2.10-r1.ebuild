# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils

MY_P="${PN}-core-${PV}"

DESCRIPTION="Xapian Probabilistic Information Retrieval library"
HOMEPAGE="http://www.xapian.org/"
SRC_URI="http://oligarchy.co.uk/xapian/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc static-libs -sse +sse2 +brass +chert +flint +inmemory +remote +geospatial"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_configure() {
	local myconf=""

	ewarn
	if use sse2; then
		ewarn "Using sse2"
		myconf="${myconf} --enable-sse=sse2"
	else
		if use sse; then
			ewarn "Using sse"
			myconf="${myconf} --enable-sse=sse"
		else
			ewarn "Disabling sse and sse2"
			myconf="${myconf} --disable-sse"
		fi
	fi
	ewarn

	myconf="${myconf} $(use_enable static-libs static)"

	use brass || myconf="${myconf} --disable-backend-brass"
	use chert || myconf="${myconf} --disable-backend-chert"
	use flint || myconf="${myconf} --disable-backend-flint"
	use inmemory || myconf="${myconf} --disable-backend-inmemory"
	use remote || myconf="${myconf} --disable-backend-remote"

	use debug && myconf="${myconf} --enable-assertions"

	if use geospatial; then
		epatch ${FILESDIR}/1.2.7-geospatial-xapian-core.patch
	fi

	econf $myconf
}

src_install() {
	emake DESTDIR="${D}" install

	mv "${D}usr/share/doc/xapian-core" "${D}usr/share/doc/${PF}"
	use doc || rm -fr "${D}usr/share/doc/${PF}"

	dodoc AUTHORS HACKING PLATFORMS README NEWS
}

src_test() {
	emake check VALGRIND=
}
