# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

case $PV in *9999*) VCS_ECLASS="git-2" ;; *) VCS_ECLASS="" ;; esac

inherit eutils qt4-r2 confutils ${VCS_ECLASS}

DESCRIPTION="QStarDict is a StarDict clone written with using Qt"
HOMEPAGE="http://qstardict.ylsoftware.com/"
LICENSE="GPL-2"
if [ -n "${VCS_ECLASS}" ]; then
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/therussianphysicist/qstardict"
else
	KEYWORDS="amd64 ~ia64 x86"
	SRC_URI="http://qstardict.ylsoftware.com/files/${P}.tar.bz2"
	PATCHES=( "${FILESDIR}/glib.patch" )
fi
SLOT="0"

PLUGINS="stardict swac web"
IUSE_PLUGINS=""
for p in $PLUGINS; do IUSE_PLUGINS="${IUSE_PLUGINS} plugin_${p}"; done;
IUSE="dbus nls ${IUSE_PLUGINS}"
REQUIRED_USE="|| ( ${IUSE_PLUGINS} )"

RDEPEND="dev-qt/qtgui:=
	dbus? ( dev-qt/qtdbus:= )
	dev-libs/glib:2
	plugin_swac? ( dev-qt/qtsql:= )"
DEPEND="${RDEPEND}"

src_configure() {
	local eplugins=()
	for f in $PLUGINS; do
		use "plugin_${f}" && eplugins+=("${f}")
	done

	QMAKE_FLAGS=(
		ENABLED_PLUGINS="${eplugins[@]}"
		LIB_DIR="${EPREFIX}/usr/$(get_libdir)/${PN}"
	)
	if ! use dbus; then
		QMAKE_FLAGS+=(NO_DBUS=1)
	fi
	if ! use nls; then
		QMAKE_FLAGS+=(NO_TRANSLATIONS=1)
	fi

	eqmake4 "${PN}".pro "${QMAKE_FLAGS[@]}"
}
