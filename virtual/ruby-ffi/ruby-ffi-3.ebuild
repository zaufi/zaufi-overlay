# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2
USE_RUBY="ruby18 ruby19 ruby20 ruby21 jruby"

inherit ruby-ng

DESCRIPTION="Virtual ebuild for the Ruby ffi library"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="ruby_targets_ruby18? ( dev-ruby/ffi[ruby_targets_ruby18] )
	ruby_targets_ruby19? ( dev-ruby/ffi[ruby_targets_ruby19] )
	ruby_targets_ruby20? ( dev-ruby/ffi[ruby_targets_ruby20] )
	ruby_targets_ruby21? ( dev-ruby/ffi[ruby_targets_ruby21] )
	ruby_targets_jruby? ( dev-java/jruby )"
DEPEND=""

pkg_setup() { :; }
src_unpack() { :; }
src_prepare() { :; }
src_compile() { :; }
src_install() { :; }
pkg_preinst() { :; }
pkg_postinst() { :; }
