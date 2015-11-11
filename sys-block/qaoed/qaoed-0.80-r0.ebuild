# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $/var/cvsroot/gentoo-x86/sys-block/qaoed/qaoed-0.80.ebuild,v 1.1 2007/05/28 07:50:33 robbat2 Exp $

inherit eutils

DESCRIPTION="Mulithreaded ATA over Ethernet storage target"
HOMEPAGE="http://pi.nxs.se/~wowie/qaoed.tgz/"
SRC_URI="http://pi.nxs.se/~wowie/qaoed.tgz/v${PV}/qaoed_v${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${S}
	emake
}

src_install() {
	into /usr
	dosbin qaoed

	doman ${S}/man/qaoed.conf.man.5
	doman ${S}/man/qaoed.man.8

	mkdir -p ${D}/etc
	cp ${S}/examples/qaoed.conf ${D}/etc/qaoed.conf.example

	newinitd ${FILESDIR}/qaoed.init qaoed

	dodoc examples/*
	dodoc *.txt
}

