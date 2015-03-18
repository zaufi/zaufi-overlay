# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpcre/libpcre-8.36.ebuild,v 1.1 2014/10/02 08:54:24 polynomial-c Exp $

EAPI="5"

inherit eutils cmake-multilib

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"
MY_P="pcre-${PV/_rc/-RC}"
if [[ ${PV} != *_rc* ]] ; then
	# Only the final releases are available here.
	SRC_URI="mirror://sourceforge/pcre/${MY_P}.tar.bz2
		ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/${MY_P}.tar.bz2"
else
	SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/Testing/${MY_P}.tar.bz2"
fi

LICENSE="BSD"
SLOT="8"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="bzip2 doc +cxx +jit pcre16 pcre32 shared-libs static-libs unicode zlib"
REQUIRED_USE=""

RDEPEND="bzip2? ( app-arch/bzip2 )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.1"
RDEPEND="${RDEPEND}
	abi_x86_32? (
		!<=app-emulation/emul-linux-x86-baselibs-20131008-r2
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
	)"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/pcre-onixs.patch"
}

multilib_src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use cxx PCRE_BUILD_PCRECPP)
		$(cmake-utils_use doc PCRE_ENABLE_DOC)
		$(cmake-utils_use jit PCRE_SUPPORT_JIT)
		$(cmake-utils_use pcre16 PCRE_BUILD_PCRE16)
		$(cmake-utils_use pcre32 PCRE_BUILD_PCRE32)
		$(cmake-utils_use_build shared-libs SHARED_LIBS)
		$(cmake-utils_use_build static-libs STATIC_LIBS)
		$(cmake-utils_use unicode PCRE_SUPPORT_UNICODE_PROPERTIES)
		-DPCRE_BUILD_PCREGREP=OFF
		-DPCRE_BUILD_TESTS=OFF
	)
	cmake-utils_src_configure
}
