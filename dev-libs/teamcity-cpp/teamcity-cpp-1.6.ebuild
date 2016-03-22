# Copyright 2016 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

if [[ ${PV} != *scm* ]]; then
    SRC_URI="https://github.com/zaufi/teamcity-cpp/archive/v${PV}.tar.gz -> ${P}.tar.gz"
else
    GIT_ECLASS="git-r3"
    EGIT_REPO_URI=( "https://github.com/zaufi/${PN}.git" )
fi

inherit cmake-utils ${GIT_ECLASS}

DESCRIPTION="C++ Unit Test Reporting to TeamCity"
HOMEPAGE="https://github.com/zaufi/teamcity-cpp"

IUSE="+boost cppunit gtest"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-util/cmake >= 2.8"
RDEPEND="
    boost? (dev-libs/boost)
    cppunit? (dev-util/cppunit)
    gtest? (dev-cpp/gtest)
  "

src_configure() {
    local mycmakeargs=(
        $(cmake-utils_use_enable boost BOOST)
        $(cmake-utils_use_enable cppunit CPPUNIT)
        $(cmake-utils_use_enable gtest GTEST)
    )
    cmake-utils_src_configure
}
