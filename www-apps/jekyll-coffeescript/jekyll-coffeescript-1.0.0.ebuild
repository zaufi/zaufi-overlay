# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="A CoffeeScript converter for Jekyll."
HOMEPAGE="https://github.com/jekyll/jekyll-coffeescript"
SRC_URI="https://github.com/jekyll/jekyll-coffeescript/archive/v${PV}.tar.gz -> ${P}-git.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x64-macos"
IUSE=""

ruby_add_rdepend ">=dev-ruby/coffee-script-2.2.0"
ruby_add_bdepend "www-apps/jekyll"

all_ruby_prepare() {
	sed -i -e '/bundler/d' Rakefile || die
	sed -i -e "/^RSpec/i \
		require 'jekyll'"\
		-e "/^RSpec/i \
		require 'jekyll-coffeescript'" spec/spec_helper.rb || die
}
