# Copyright 2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=EARLHOOD
MODULE_VERSION=2.00
inherit perl-module

DESCRIPTION="Reads an SGML or XML DTD and constructs an XML database of its content."
SRC_URI="mirror://sourceforge/dtdparse/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/XML-DOM
	dev-perl/XML-Parser
	dev-perl/DelimMatch"
DEPEND="${RDEPEND}"

SRC_TEST=do
