# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=2

inherit subversion

ESVN_REPO_URI="http://anonsvn.wireshark.org/wireshark/trunk"
ESVN_PROJECT="wireshark"
ESVN_BOOTSTRAP="./autogen.sh"

DESCRIPTION="A network protocol analyzer formerly known as ethereal"
HOMEPAGE="http://www.wireshark.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="adns gtk ipv6 lua portaudio gnutls gcrypt zlib kerberos threads profile smi +pcap pcre +caps selinux ssl"

RDEPEND="zlib? ( sys-libs/zlib )
        smi? ( net-libs/libsmi )
        gtk? ( >=dev-libs/glib-2.0.4
                =x11-libs/gtk+-2*
                x11-libs/pango
                dev-libs/atk )
        !gtk? ( =dev-libs/glib-1.2* )
        gnutls? ( net-libs/gnutls )
        gcrypt? ( dev-libs/libgcrypt )
        pcap? ( net-libs/libpcap )
        pcre? ( dev-libs/libpcre )
        caps? ( sys-libs/libcap )
        adns? ( net-libs/adns )
        kerberos? ( virtual/krb5 )
        portaudio? ( media-libs/portaudio )
        lua? ( >=dev-lang/lua-5.1 )
        selinux? ( sec-policy/selinux-wireshark )
        ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
        >=dev-util/pkgconfig-0.15.0
        dev-lang/perl
        sys-devel/bison
        sys-devel/flex
        sys-apps/sed"

pkg_setup() {
        if ! use gtk; then
                ewarn "USE=-gtk will mean no gui called wireshark will be created and"
                ewarn "only command line utils are available"
        fi

        # Add group for users allowed to sniff.
        enewgroup wireshark || die "Failed to create wireshark group"
}

src_unpack() {
    subversion_src_unpack

    cd ${S}/epan
    epatch "${FILESDIR}"/wireshark-except-double-free.diff
}

src_compile() {
        # optimization bug, see bug #165340, bug #40660
        if [[ $(gcc-version) == 3.4 ]] ; then
                elog "Found gcc 3.4, forcing -O3 into CFLAGS"
                replace-flags -O? -O3
        elif [[ $(gcc-version) == 3.3 || $(gcc-version) == 3.2 ]] ; then
                elog "Found <=gcc-3.3, forcing -O into CFLAGS"
                replace-flags -O? -O
        fi

        # see bug #133092; bugs.wireshark.org/bugzilla/show_bug.cgi?id=1001
        # our hardened toolchain bug
        filter-flags -fstack-protector

        # profile and -fomit-frame-pointer are incompatible, bug #215806
        use profile && filter-flags -fomit-frame-pointer

        local myconf
        if use gtk; then
                einfo "Building with gtk support"
        else
                einfo "Building without gtk support"
                myconf="${myconf} --disable-wireshark"
        fi

        # Workaround bug #213705. If krb5-config --libs has -lcrypto then pass
        # --with-ssl to ./configure. (Mimics code from acinclude.m4).
        if use kerberos; then
                case `krb5-config --libs` in
                        *-lcrypto*) myconf="${myconf} --with-ssl" ;;
                esac
        fi

        # dumpcap requires libcap, setuid-install requires dumpcap
        econf $(use_enable profile profile-build) \
              $(use_with gnutls) \
              $(use_with gcrypt) \
              $(use_enable gtk wireshark) \
              $(use_enable ipv6) \
              $(use_enable threads) \
              $(use_with lua) \
              $(use_with adns) \
              $(use_with kerberos krb5) \
              $(use_with smi libsmi) \
              $(use_with pcap) \
              $(use_with zlib) \
              $(use_with pcre) \
              $(use_with portaudio) \
              $(use_with caps libcap) \
              $(use_enable pcap setuid-install) \
              --sysconfdir=/etc/wireshark \
              --disable-usr-local \
              --disable-warnings-as-errors \
              ${myconf} || die "econf failed"

        emake || die "emake failed"
}

src_install () {
        emake DESTDIR="${D}" install || die "emake install failed"

        fowners 0:wireshark /usr/bin/tshark
        fperms 6550 /usr/bin/tshark
        use pcap && fowners 0:wireshark /usr/bin/dumpcap
        use pcap && fperms 6550 /usr/bin/dumpcap

        insinto /usr/include/wiretap
        doins wiretap/wtap.h

        # FAQ is not required as is installed from help/faq.txt
        dodoc AUTHORS ChangeLog NEWS README{,bsd,linux,macos,vmware} doc/randpkt.txt

        if use gtk ; then
                insinto /usr/share/icons/hicolor/16x16/apps
                newins image/hi16-app-wireshark.png wireshark.png
                insinto /usr/share/icons/hicolor/32x32/apps
                newins image/hi32-app-wireshark.png wireshark.png
                insinto /usr/share/icons/hicolor/48x48/apps
                newins image/hi48-app-wireshark.png wireshark.png
                insinto /usr/share/applications
                doins wireshark.desktop
        fi
}

pkg_postinst() {
        echo
        ewarn "With version 0.99.7, all function calls that require elevated privileges"
        ewarn "have been moved out of the GUI to dumpcap. WIRESHARK CONTAINS OVER ONE"
        ewarn "POINT FIVE MILLION LINES OF SOURCE CODE. DO NOT RUN THEM AS ROOT."
        ewarn
        ewarn "NOTE: To run wireshark as normal user you have to add yourself into"
        ewarn "wireshark group. This security measure ensures that only trusted"
        ewarn "users allowed to sniff your traffic."
        echo
}
