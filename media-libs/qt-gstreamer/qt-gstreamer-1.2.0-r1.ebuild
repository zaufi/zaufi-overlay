# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

QT_MINIMAL="4.7.0"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.xz"
	KEYWORDS="amd64 ~arm ppc ppc64 x86"
else
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI=( "git://anongit.freedesktop.org/gstreamer/${PN}" )
	KEYWORDS=""
fi

inherit cmake-utils ${GIT_ECLASS}

DESCRIPTION="QtGStreamer provides C++ bindings for GStreamer with a Qt-style API"
HOMEPAGE="http://gstreamer.freedesktop.org/modules/qt-gstreamer.html"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="test"

RDEPEND="
	dev-libs/glib:2
	>=dev-libs/boost-1.40:=
	>=dev-qt/qtcore-${QT_MINIMAL}:4
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:4
	>=dev-qt/qtgui-${QT_MINIMAL}:4
	>=dev-qt/qtopengl-${QT_MINIMAL}:4
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
"
DEPEND="
	${RDEPEND}
	test? ( >=dev-qt/qttest-${QT_MINIMAL}:4 )
"

# bug 497880
RESTRICT="test"

src_prepare() {
	# Wrap all boost #include due a bug:
	# https://bugreports.qt.io/browse/QTBUG-22829
	ebegin "Wrapping #include <boost/...> into #ifndef Q_MOC_RUN/#endif"
	for i in `find . -name '*.h' -o -name '*.cpp'`; do
		sed -f "${FILESDIR}/wrap-boost-headers.sed" -i "${i}"
	done
	eend $?
        cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DQTGSTREAMER_EXAMPLES=OFF
		$(cmake-utils_use test QTGSTREAMER_TESTS)
	)

	cmake-utils_src_configure
}
