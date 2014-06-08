# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/listen/listen-1.3.1-r1.ebuild,v 1.2 2013/12/22 18:58:20 blueness Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 ruby20 ruby21 jruby"

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
