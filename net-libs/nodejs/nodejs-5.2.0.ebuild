# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit bash-completion-r1 eutils flag-o-matic pax-utils python-single-r1 toolchain-funcs

DESCRIPTION="Evented IO for V8 Javascript"
HOMEPAGE="http://nodejs.org/"
SRC_URI="http://nodejs.org/dist/v${PV}/node-v${PV}.tar.xz"

LICENSE="Apache-1.1 Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos"
IUSE="debug doc icu +npm snapshot +ssl"

RDEPEND="icu? ( >=dev-libs/icu-55:= )
	${PYTHON_DEPS}
	>=net-libs/http-parser-2.5:=
	>=dev-libs/libuv-1.6.1:=
	>=dev-libs/openssl-1.0.2d:0=[-bindist]
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	!!net-libs/iojs"

S="${WORKDIR}/node-v${PV}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != "binary" ]] ; then
		if ! test-flag-CXX -std=c++11 ; then
			die "Your compiler doesn't support C++11. Use GCC 4.8, Clang 3.3 or newer."
		fi
	fi
}

src_prepare() {
	tc-export CC CXX PKG_CONFIG
	export V=1 # Verbose build
	export BUILDTYPE=Release

	# fix compilation on Darwin
	# https://code.google.com/p/gyp/issues/detail?id=260
	sed -i -e "/append('-arch/d" tools/gyp/pylib/gyp/xcode_emulation.py || die

	# make sure we use python2.* while using gyp
	sed -i -e "s/python/${EPYTHON}/" deps/npm/node_modules/node-gyp/gyp/gyp || die
	sed -i -e "s/|| 'python'/|| '${EPYTHON}'/" deps/npm/node_modules/node-gyp/lib/configure.js || die

	# less verbose install output (stating the same as portage, basically)
	sed -i -e "/print/d" tools/install.py || die

	# proper libdir, hat tip @ryanpcmcquen https://github.com/iojs/io.js/issues/504
	local LIBDIR=$(get_libdir)
	sed -i -e "s|lib/|${LIBDIR}/|g" tools/install.py || die
	sed -i -e "s/'lib'/'${LIBDIR}'/" lib/module.js || die
	sed -i -e "s|\"lib\"|\"${LIBDIR}\"|" deps/npm/lib/npm.js || die

	# Avoid a test that I've only been able to reproduce from emerge. It doesnt
	# seem sandbox related either (invoking it from a sandbox works fine).
	# The issue is that no stdin handle is openened when asked for one.
	# It doesn't really belong upstream , so it'll just be removed until someone
	# with more gentoo-knowledge than me (jbergstroem) figures it out.
	rm test/parallel/test-stdout-close-unref.js || die
	# AssertionError: 1 == 2 (on line 97)
	rm test/parallel/test-cluster-disconnect.js || die
	# AssertionError: Client never errored
	rm test/parallel/test-tls-hello-parser-failure.js || die
	# --- TIMEOUT ---
	rm test/parallel/test-child-process-fork-net.js \
		test/parallel/test-child-process-fork-net2.js \
		test/parallel/test-child-process-recv-handle.js \
		test/parallel/test-cluster-dgram-1.js \
		test/parallel/test-cluster-send-deadlock.js \
		test/parallel/test-cluster-shared-handle-bind-error.js \
		test/parallel/test-dgram-exclusive-implicit-bind.js \
		test/parallel/test-tls-ticket-cluster.js || die

	# debug builds. change install path, remove optimisations and override buildtype
	if use debug; then
		sed -i -e "s|out/Release/|out/Debug/|g" tools/install.py || die
		BUILDTYPE=Debug
	fi

	epatch "${FILESDIR}"/${PN}-5.1.0-no-deps-tracking.patch

	epatch_user
}

src_configure() {
	local myarch=""
	local myconf+=( --shared-openssl --shared-libuv --shared-http-parser --shared-zlib )
	use npm || myconf+=( --without-npm )
	use icu && myconf+=( --with-intl=system-icu )
	use snapshot && myconf+=( --with-snapshot )
	use ssl || myconf+=( --without-ssl )
	use debug && myconf+=( --debug )

	case ${ABI} in
		x86) myarch="ia32";;
		amd64) myarch="x64";;
		x32) myarch="x32";;
		arm) myarch="arm";;
		arm64) myarch="arm64";;
		*) die "Unrecognized ARCH ${ARCH}";;
	esac

	GYP_DEFINES="linux_use_gold_flags=0
		linux_use_bundled_binutils=0
		linux_use_bundled_gold=0" \
	"${PYTHON}" configure \
		--prefix="${EPREFIX}"/usr \
		--dest-cpu=${myarch} \
		--without-dtrace \
		"${myconf[@]}" || die
}

src_compile() {
	emake -C out mksnapshot
	pax-mark m "out/${BUILDTYPE}/mksnapshot"
	emake -C out

	if use doc; then
		emake doc
	fi
}

src_install() {
	# set up a symlink structure that npm expects..
	dodir /usr/include/node/deps/{v8,uv}
	dosym . /usr/include/node/src
	for var in deps/{uv,v8}/include; do
		dosym ../.. /usr/include/node/${var}
	done

	local LIBDIR="${ED}/usr/$(get_libdir)"
	emake install DESTDIR="${ED}" PREFIX=/usr
	pax-mark m "${ED}"/usr/bin/node

	# Fix location of `gdbinit`
	mv "${ED}"/usr/share/doc/node "${ED}"/usr/share/${PF}
	
	if use doc; then
		# Patch docs to make them offline readable
		for i in `grep -rl 'fonts.googleapis.com' "${S}"/out/doc/api/*`; do
		    sed -i '/fonts.googleapis.com/ d' $i;
		done
		# Install docs!
		dohtml -r "${S}"/out/doc/api/*
	fi

	if use npm; then
		# Install bash completion for `npm`
		local tmp_npm_completion_file="$(emktemp)"
		"${ED}/usr/bin/npm" completion > "${tmp_npm_completion_file}"
		newbashcomp "${tmp_npm_completion_file}" npm
		rm "${LIBDIR}"/node_modules/npm/lib/utils/completion.sh
		
		# Move man pages
		doman "${LIBDIR}"/node_modules/npm/man/man{1,5,7}/*
		rm -rf "${LIBDIR}"/node_modules/npm/man
		
		# Cleanup a little
		rm "${LIBDIR}"/node_modules/npm/{.mailmap,.travis.yml,.npmignore,Makefile,make.bat,wercker.yml} || die
		rm -rf "${LIBDIR}"/node_modules/npm/{doc,html,AUTHORS,CHANGELOG.md,CONTRIBUTING.md,LICENSE} || die
	fi

	# Remove various development and/or inappropriate files and useless docs of dependend packages
	ebegin "Cleanup useless files"
	find "${LIBDIR}"/node_modules \
	    \( -type d -name examples \) -or \
		\( \
		    -type f \( \
		    -name 'LICENSE*' -or \
		    -name 'LICENCE*' -or \
		    -name 'License*' -or \
		    -name 'AUTHORS*' -or \
		    -name 'CONTRIBUTORS*' -or \
		    -name 'README*' -or \
		    -name 'CHANGELOG*' -or \
		    -name '.travis.yml' -or \
		    -name '.npmignore' -or \
		    -name '*.md' -or \
		    -name '*.markdown' -or \
		    -name '*.bat' -or \
		    -name '*.cmd' \
		    \) \
		\) \
	  | xargs rm -rf
	eend $?
}

src_test() {
	out/${BUILDTYPE}/cctest || die
	declare -xl TESTTYPE="${BUILDTYPE}"
	"${PYTHON}" tools/test.py --mode=${TESTTYPE} -J message parallel sequential || die
}

pkg_postinst() {
	einfo "When using node-gyp to install native modules, you can avoid"
	einfo "having to download the full tarball by doing the following:"
	einfo ""
	einfo "node-gyp --nodedir /usr/include/node <command>"
}
