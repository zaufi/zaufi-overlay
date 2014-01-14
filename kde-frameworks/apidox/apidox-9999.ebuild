# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME=kapidox
FRAMEWORKS_DISABLE_DOXYGEN="true"
inherit kde-frameworks

DESCRIPTION="API documentation generation and assets for frameworks"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-doc/doxygen
"

src_install() {
    kde-frameworks_src_install

    # Install scripts to be used by other KF5 packages to generate API docs
    insinto /usr/share/${PN}
    doins ${S}/src/*.sh ${S}/src/*.local

    insinto /usr/share/doc/HTML/en/common
    doins ${S}/common/{api_searchbox.html,Doxyfile.global,flat.css,kde-localised.css.template}
    doins ${S}/common/{kde.css,kde_logo.png,kmenu.png,print.css}
}
