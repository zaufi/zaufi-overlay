# Copyright 2016 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v3

EAPI="6"

inherit cmake-utils

DESCRIPTION="C++ library to integrate various testing libraries/frameworks with JetBrains TeamCity"
HOMEPAGE="https://github.com/zaufi/teamcity-cpp"
SRC_URI="https://github.com/zaufi/${PN}/archive/release%2F${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

IUSE="boost cppunit gtest"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
    >=dev-util/cmake-3.7.2
    boost?   ( >=dev-libs/boost-1.63 )
    cppunit? ( >=dev-utils/cppunit-1.13 )
    gtest?   ( >=dev-cpp/gtest-1.6 )
    "
RDEPEND=""

S="${WORKDIR}/teamcity-cpp-release-${PV}"

src_configure() {
    local mycmakeargs=(
        -DCMAKE_INSTALL_PREFIX="${EPREFIX}${PREFIX}/share"
        -DENABLE_BOOST="$(usex boost)"
        -DENABLE_CPPUNIT="$(usex cppunit)"
        -DENABLE_GTEST="$(usex gtest)"
    )
    cmake-utils_src_configure
}
