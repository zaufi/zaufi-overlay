# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="collection of Gentoo eclass manpages"
HOMEPAGE="https://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos ~x86-solaris"
IUSE=""

S=${WORKDIR}

genit() {
	local e=${1:-${ECLASSDIR}}
	einfo "Generating man pages from: ${e}"
	# Need `bash` because the .sh isn't +x on the servers #451352
	env ECLASSDIR=${e} bash "${FILESDIR}"/eclass-to-manpage.sh || die
}

src_compile() {
	# First process any eclasses found in overlays.  Then process
	# the main eclassdir last so that its output will clobber anything
	# that might have come from overlays.  Main tree wins!
	local o e
	# NOTE Paludis (at least 2.6.0 and less) have limited emulation
	# of `portageq`, so lets make some hardcode here as a "temporary"
	# workaround %-)
	genit "/usr/portage/eclass" || die
}

src_install() {
	doman *.5
}
