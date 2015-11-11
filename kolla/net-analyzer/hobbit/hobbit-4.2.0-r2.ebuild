# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Tool for monitoring servers, applications and networks."
HOMEPAGE="http://www.hswn.dk/hobbit/"
SRC_URI="http://www.hswn.dk/hobbitsw/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 m68k arm mips ppc"
IUSE="client-only"

DEPEND="sys-devel/gcc
        sys-devel/make
		dev-libs/libpcre"

CFLAGS=${CFLAGS/-j/}

RDEPEND=""
# S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewuser hobbit-c -1 -1 /usr/lib/hobbit/client adm
}

src_unpack() {
	unpack ${A} || die
	epatch ${FILESDIR}/${P}-raid.diff
	use client-only && cp -v ${FILESDIR}/Makefile.client ${S}/Makefile
}

src_compile() {
	emake INSTALLROOT=${D} || die
}

src_install() {
	einstall INSTALLROOT=${D} || die
	dodoc Changes README README.CLIENT docs/*.txt
	dohtml docs/*.html

	keepdir /etc/hobbit
	keepdir /var/tmp/hobbit
	keepdir /var/log/hobbit
	keepdir /usr/lib/hobbit/client/ext

	fowners root:adm /var/tmp/hobbit
	fperms 770 /var/tmp/hobbit
	fowners root:adm /var/log/hobbit
	fperms 770 /var/log/hobbit

	mv ${D}/usr/lib/hobbit/client/etc/* ${D}/etc/hobbit/

	rmdir ${D}/usr/lib/hobbit/client/etc
	rmdir ${D}/usr/lib/hobbit/client/tmp
	rmdir ${D}/usr/lib/hobbit/client/logs

	dosym /etc/hobbit /usr/lib/hobbit/client/etc
	dosym /var/tmp/hobbit /usr/lib/hobbit/client/tmp
	dosym /var/log/hobbit /usr/lib/hobbit/client/logs

	use client-only && newinitd ${FILESDIR}/hobbit-client.init hobbit-client
}

pkg_postinst() {
	einfo
	einfo
	einfo "Hobbit client installation successful!!!"
	einfo
	einfo
	einfo "Don't forget to configure the Hobbit Server's IP address:"
	einfo "BBDISP in /etc/hobbit/hobbitclient.cfg"
	einfo
	einfo
	einfo "Now you can start the Hobbit client:"
	einfo "/etc/init.d/hobbit-client start"
	einfo
	einfo
			
}
