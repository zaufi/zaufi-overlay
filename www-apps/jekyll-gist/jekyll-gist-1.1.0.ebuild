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

DESCRIPTION="Liquid tag for displaying GitHub Gists in Jekyll sites: {% gist %}."
HOMEPAGE="https://github.com/jekyll/jekyll-gist"
SRC_URI="https://github.com/jekyll/jekyll-gist/archive/v${PV}.tar.gz -> ${P}-git.tgz"
RESTRICT=mirror

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x64-macos"
IUSE=""

ruby_add_rdepend ">=www-apps/jekyll-2.2"
