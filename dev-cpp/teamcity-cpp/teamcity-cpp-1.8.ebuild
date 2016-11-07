# Copyright 2016 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v3

EAPI="5"

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
    dev-util/cmake
    boost? ( >=dev-libs/boost-1.42 )
    cppunit? ( >=dev-utils/cppunit-1.13 )
    gtest? ( >=dev-cpp/gtest-1.6 )
    "
RDEPEND=""

S="${WORKDIR}/teamcity-cpp-release-${PV}"

src_configure() {
    local mycmakeargs=(
        -DCMAKE_INSTALL_PREFIX="${EPREFIX}${PREFIX}/share"
        $(cmake-utils_use_enable boost BOOST)
        $(cmake-utils_use_enable cppunit CPPUNIT)
        $(cmake-utils_use_enable gtest GTEST)
    )
    cmake-utils_src_configure
}
