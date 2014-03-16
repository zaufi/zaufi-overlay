# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/redcarpet/redcarpet-2.3.0-r1.ebuild,v 1.1 2014/01/18 06:45:22 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOCS="README.markdown CONTRIBUTING.md CHANGELOG.md doc"
RUBY_FAKEGEM_TASK_TEST="test:unit"

inherit multilib ruby-fakegem

SRC_URI="https://github.com/vmg/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
DESCRIPTION="A Ruby wrapper for Upskirt."
HOMEPAGE="https://github.com/vmg/redcarpet"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

all_ruby_prepare() {
	# Remove test depending on compile, since we handle compilation
	# directly.
	sed -i -e 's/=> :compile//' tasks/testing.rake || die
}

each_ruby_configure() {
	${RUBY} -Cext/redcarpet extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext/${PN}
	cp ext/${PN}/*$(get_modname) lib || die
}
