# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit user systemd

NAME="btsync"
DESCRIPTION="Fast, unlimited and secure file-syncing. Free from the cloud."
HOMEPAGE="http://www.getsync.com/"
SRC_URI="
	amd64?	( http://syncapp.bittorrent.com/${PV}/btsync_x64-${PV}.tar.gz )
	x86? ( http://syncapp.bittorrent.com/${PV}/btsync_i386-${PV}.tar.gz )"

RESTRICT="mirror strip"
LICENSE="BitTorrent"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}"

pkg_setup() {
	local btsyncuser="btsync"
	enewgroup ${btsyncuser}
	enewuser btsync -1 -1 /var/lib/${NAME} ${btsyncuser}
}

src_install() {
	# Install the executable
	exeinto "/opt/${NAME}"
	doexe "${S}/${NAME}"

	# Install a default configuration file
	insinto "/etc/${NAME}"
	newins "${FILESDIR}/btsync.conf" "${NAME}.conf"

	# Install the OpenRC init file
	doinitd "${FILESDIR}/init.d/${NAME}"

	# Install the systemd unit file
	systemd_dounit "${FILESDIR}/systemd/${NAME}.service"

	for x in {/var/lib,/run}/${NAME}; do
		keepdir "${x}"
		fowners btsync:btsync "${x}"
	done
}

pkg_postinst() {
	elog "In order for shared files between local users to be as easy as possible,"
	elog "please set up ACLs on your system."
	elog ""
	elog "You will also need to configure btsync by editing /etc/btsync/config"
	elog ""
	elog "After checking your config, start the service and point your browser to"
	elog "http://localhost:8888 , the default username and password is admin/admin."
}
