# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils

DESCRIPTION="A lightweight and flexible command-line JSON processor"
HOMEPAGE="https://stedolan.github.com/jq/"
SRC_URI="https://github.com/stedolan/${PN}/releases/download/${P}/${P}.tar.gz"

LICENSE="MIT CC-BY-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs test"

DEPEND="sys-devel/bison
	sys-devel/flex
	test? ( dev-util/valgrind )"

DOCS=( AUTHORS README )

src_configure() {
	# don't try to rebuild docs
	econf \
		--disable-docs \
		$(use_enable static-libs static)
}

src_install() {
	default
	find "${ED}" -name libjq.la -delete
}
