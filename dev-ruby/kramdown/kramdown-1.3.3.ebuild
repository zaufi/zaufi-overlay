# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/kramdown/kramdown-1.2.0-r1.ebuild,v 1.2 2014/04/19 12:56:15 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_EXTRADOC="README.md AUTHORS CONTRIBUTERS"

RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit ruby-fakegem

DESCRIPTION="Yet-another-markdown-parser but fast, pure Ruby, using a strict syntax definition"
HOMEPAGE="http://kramdown.rubyforge.org/"
SRC_URI="https://github.com/gettalong/kramdown/archive/REL_$(sed 's,\.,_,g' <<<${PV}).tar.gz -> ${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc"

RDEPEND=""
DEPEND=""

ruby_add_bdepend "doc? ( dev-ruby/rdoc )"

#all_ruby_prepare() {
#	if ! use latex; then
#		# Remove latex tests. They will fail gracefully when latex isn't
#		# present at all, but not when components are missing (most
#		# notable ucs.sty).
#		sed -i -e '/latex -v/,/^  end/ s:^:#:' test/test_files.rb || die
#	fi
#}

all_ruby_install() {
	all_fakegem_install

	doman man/man1/kramdown.1
}
