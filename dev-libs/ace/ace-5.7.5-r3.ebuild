# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="The Adaptive Communications Environment"
HOMEPAGE="http://www.cs.wustl.edu/~schmidt/ACE.html"
SRC_URI="http://download.dre.vanderbilt.edu/previous_versions/ACE-${PV}.tar.bz2
	doc? ( http://download.dre.vanderbilt.edu/previous_versions/ACE-html-${PV}.tar.bz2 )"

LICENSE="ACE BSD BSD-4 BSD-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="debug doc ipv6 static"

COMMON_DEPEND="dev-libs/openssl"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/ACE_wrappers"

src_prepare() {
	cd "${S}"
	# Let's avoid autotools. http://bugs.gentoo.org/328027.
	#if has_version ">=dev-libs/openssl-1.0.0"; then
	#	sed -i -e 's:SSL_METHOD:const SSL_METHOD:' configure || die
	#fi

	sed -i -e 's/-O3//' configure || die
	epatch "${FILESDIR}/ACE-5.7.5-add-static-pc-files.patch"
	epatch "${FILESDIR}/ace-fix-openssl-detection-without-rebuilding-configure.patch"
	epatch "${FILESDIR}/do-not-build-useless-crap.patch"
	epatch "${FILESDIR}/do-not-fail-if-SO_PORTREUSE-unsupported.patch"
	epatch "${FILESDIR}/openssl-without-sslv2.patch"
}

src_configure() {
	ECONF_SOURCE="${S}"
	mkdir -p build
	cd build
	econf \
		--enable-lib-all \
		$(use_enable ipv6) \
		$(use_enable debug) \
		$(use_enable !debug optimize) \
		$(use_enable static) \
		--disable-ace-examples \
		--disable-acexml \
		--disable-gperf \
		--disable-logging \
		--disable-ace-tests \
		--enable-ssl \
		--enable-symbol-visibility \
		--with-openssl \
		--without-tao \
		--without-x \
		|| die "econf died"
}

src_compile() {
	cd build
	emake
}

src_install() {
	cd build
	emake ACE_ROOT="${S}" DESTDIR="${D}" install || die "failed to install"
	# punt gperf stuff
	rm -rf "${D}/usr/bin" "${D}/usr/share"
	# remove PACKAGE_* definitions from installed config.h (#192676)
	sed -i -e "s:^[ \t]*#define[ \t]\+PACKAGE_.*$:/\* & \*/:g" "${D}/usr/include/ace/config.h"

	# Install some docs
	cd "${S}"
	dodoc README NEWS FAQ COPYING ChangeLog AUTHORS THANKS VERSION || die

	# Install API docs
	cd ${WORKDIR}
	use doc && dohtml -r "${WORKDIR}"/html/*
}

src_test() {
	cd "${S}/build"
	emake ACE_ROOT="${S}" check || die "self test failed"
}

pkg_postinst() {

	local CC_MACHINE=$($(tc-getCC) -dumpmachine)
	if [ -d "/usr/$(get_libdir)/gcc-lib/${CC_MACHINE}/$(gcc-fullversion)/include/ace" ]; then
		ewarn "moving /usr/$(get_libdir)/gcc-lib/${CC_MACHINE}/$(gcc-fullversion)/include/ace to"
		ewarn "ace.old"
		ewarn "This is required, as anything trying to compile against ACE will"
		ewarn "have problems with conflicting OS.h files if this is not done."
		mv "/usr/$(get_libdir)/gcc-lib/${CC_MACHINE}/$(gcc-fullversion)/include/ace" \
			"/usr/$(get_libdir)/gcc-lib/${CC_MACHINE}/$(gcc-fullversion)/include/ace.old"
	fi
}
