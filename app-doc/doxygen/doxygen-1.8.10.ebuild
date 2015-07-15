# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doxygen/doxygen-1.8.9.1.ebuild,v 1.4 2015/05/27 11:02:08 ago Exp $

EAPI=4
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit cmake-utils eutils fdo-mime flag-o-matic python-any-r1 qt4-r2

DESCRIPTION="Documentation system for most programming languages"
HOMEPAGE="http://www.doxygen.org/"
SRC_URI="http://ftp.stack.nl/pub/users/dimitri/${P}.src.tar.gz
	http://dev.gentoo.org/~xarthisius/distfiles/doxywizard.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="clang doc dot doxysearch qt4 latex sqlite"

#missing SerbianCyrilic, JapaneseEn, KoreanEn, Chinesetraditional

LANGS=(hy ar pt_BR ca zh cs de da eo es fa fi fr el hr hu id it ja ko lt mk
nl nb pl pt ro ru sl sk sr sv tr uk vi af)
for X in "${LANGS[@]}" ; do
	IUSE="${IUSE} linguas_${X}"
done

RDEPEND="app-text/ghostscript-gpl
	dev-lang/perl
	virtual/libiconv
	clang? ( sys-devel/clang )
	dot? (
		media-gfx/graphviz
		media-libs/freetype
	)
	doxysearch? ( =dev-libs/xapian-1.2* )
	latex? ( app-text/texlive[extra] )
	qt4? ( dev-qt/qtgui:4 )
	sqlite? ( dev-db/sqlite:3 )
	"

DEPEND="dev-util/cmake
	sys-devel/flex
	sys-devel/bison
	doc? ( ${PYTHON_DEPS} )
	${RDEPEND}"

RESTRICT="mirror test"

get_langs() {
	# using only user set linguas also fixes #263641
	my_linguas=()
	for lingua in ${LINGUAS}; do
		if has ${lingua} "${LANGS[@]}"; then
			case ${lingua} in
				hy) lingua=am ;;
				pt_BR) lingua=br ;;
				zh*) lingua=cn ;;
				cs) lingua=cz ;;
				da) lingua=dk ;;
				el*) lingua=gr ;;
				ja*) lingua=jp ;;
				ko) lingua=kr ;;
				nb) lingua=no ;;
				sl) lingua=si ;;
				tr*) lingua=tr ;;
				uk) lingua=ua ;;
				af) lingua=za ;;
			esac
			has ${lingua} "${my_linguas[@]}" ||
				my_linguas+=(${lingua})
		fi
	done
	f_langs="${my_linguas[@]}"
	echo ${f_langs// /;}
}

pkg_setup() {
	use doc && python-any-r1_pkg_setup
}

src_prepare() {
	# Call dot with -Teps instead of -Tps for EPS generation - bug #282150
	sed -i -e '/addJob("ps"/ s/"ps"/"eps"/g' src/dot.cpp || die

	# fix pdf doc
	sed -i.orig -e "s:g_kowal:g kowal:" \
		doc/maintainers.txt || die

	if is-flagq "-O3" ; then
		echo
		ewarn "Compiling with -O3 is known to produce incorrectly"
		ewarn "optimized code which breaks doxygen."
		echo
		elog "Continuing with -O2 instead ..."
		echo
		replace-flags "-O3" "-O2"
	fi
}

src_configure() {
	local linguas="`$(get_langs)`"
	local nls_opt
	if [ -z "${linguas}" ]; then
		nls_opt='-Denglish_only=ON'
	else
		nls_opt="-DLANG_CODES='${linguas}'"
	fi
	local mycmakeargs=(
		${nls_opt}
		$(cmake-utils_use doc build_doc)
		$(cmake-utils_use clang use_libclang)
		$(cmake-utils_use doxysearch build_search)
		$(cmake-utils_use qt4 build_wizard)
		$(cmake-utils_use sqlite use_sqlite3)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	# generate html and pdf (if tetex in use) documents.
	# errors here are not considered fatal, hence the ewarn message
	# TeX's font caching in /var/cache/fonts causes sandbox warnings,
	# so we allow it.
	if use doc; then
		cd "${BUILD_DIR}" && emake docs
		if ! use dot; then
			sed -i -e "s/HAVE_DOT               = YES/HAVE_DOT    = NO/" \
				{Doxyfile,doc/Doxyfile} \
				|| ewarn "disabling dot failed"
		fi
		if use latex; then
			addwrite /var/cache/fonts
			addwrite /var/cache/fontconfig
			addwrite /usr/share/texmf/fonts/pk
			addwrite /usr/share/texmf/ls-R
			make pdf || ewarn '"make pdf docs" failed.'
		else
			cp doc/Doxyfile doc/Doxyfile.orig
			cp doc/Makefile doc/Makefile.orig
			sed -i.orig -e "s/GENERATE_LATEX    = YES/GENERATE_LATEX    = NO/" \
				doc/Doxyfile
			sed -i.orig -e "s/@epstopdf/# @epstopdf/" \
				-e "s/@cp Makefile.latex/# @cp Makefile.latex/" \
				-e "s/@sed/# @sed/" doc/Makefile
			make docs || ewarn '"make docs" failed.'
		fi
	fi
}

src_install() {
	cmake-utils_src_install

	if use qt4; then
		doicon "${DISTDIR}/doxywizard.png"
		make_desktop_entry doxywizard "DoxyWizard ${PV}" \
			"/usr/share/pixmaps/doxywizard.png" \
			"Development"
	fi

	dodoc LANGUAGE.HOWTO README.md

	# pdf and html manuals
	if use doc; then
		cd "${BUILD_DIR}"
		dohtml -r html/*
		use latex && dodoc latex/doxygen_manual.pdf
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	elog
	elog "The USE flags qt4, doc, and latex will enable doxywizard, or"
	elog "the html and pdf documentation, respectively.  For examples"
	elog "and other goodies, see the source tarball.  For some example"
	elog "output, run doxygen on the doxygen source using the Doxyfile"
	elog "provided in the top-level source dir."
	elog
	elog "Disabling the dot USE flag will remove the GraphViz dependency,"
	elog "along with Doxygen's ability to generate diagrams in the docs."
	elog "See the Doxygen homepage for additional helper tools to parse"
	elog "more languages."
	elog
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
