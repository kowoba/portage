# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/www/viewcvs.gentoo.org/raw_cvs/gentoo-x86/app-admin/scotty/Attic/scotty-2.1.11.ebuild,v 1.13 2006/08/19 08:26:14 phreak dead $

EAPI=4

# inherit eutils autotools
inherit autotools-utils

DESCRIPTION="tcl network management extension"
HOMEPAGE="http://wwwhome.cs.utwente.nl/~schoenw/scotty"
SRC_URI="ftp://ftp.ibr.cs.tu-bs.de/pub/local/tkined/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 x86 ppc arm m68k"
IUSE=""

DEPEND="sys-devel/flex
	sys-devel/bison
	dev-lang/perl
	dev-lang/tcl
	dev-lang/tk
	sys-devel/autoconf"

RDEPEND=""

src_prepare() {
#	epatch "${FILESDIR}"/"${P}"-Makefile.patch
	epatch "${FILESDIR}"/"${P}"-mibs.patch
	epatch "${FILESDIR}"/"${P}"-resolv.patch
	epatch "${FILESDIR}"/"${P}"-straps.patch
#	epatch "${FILESDIR}"/"${P}"-suse.patch
	epatch "${FILESDIR}"/"${P}"-tcl.patch
	epatch "${FILESDIR}"/"${P}"-typo.patch
	epatch "${FILESDIR}"/"${P}"-vars.patch
	epatch "${FILESDIR}"/"${P}"-paths.patch
	cd "${S}"/unix
	eautoconf
}

src_configure() {
	cd "${S}"/unix
	econf --with-tk-config || die
}

src_compile() {
	cd "${S}"/unix
	emake || die
}

src_install() {
#	dodir /usr/share/man
#	TNM_LIBRARY=${D}/usr/lib/tnm${V} \
#		make prefix=${D}/usr \
#		MAN_INSTALL_DIR=${D}/usr/share/man install
#	make prefix=${D}/usr \
#		MAN_INSTALL_DIR=${D}/usr/share/man sinstall
	cd "${S}"/unix
	emake install DESTDIR="${D}" || die
#	cd ${D}/usr/bin
#	perl -p -i -e 's|/.*/image||' ${D}/usr/lib/tnm2.1.11/pkgIndex.tcl
#	perl -p -i -e 's|/.*/image||' ${D}/usr/lib/tkined1.4.11/pkgIndex.tcl
#	ln -s scotty2.1.11 scotty
#	ln -s tkined1.4.11 tkined
#	mv ${D}/usr/share/man/mann ${D}/usr/share/man/man3
#	cd ${D}/usr/share/man/man3
#	for f in `find ./ -name "*.n"`; do
#		echo ${f} `echo ${f}|cut -d. -f2|cut -d/ -f2`
#		mv ${f} `echo ${f}|cut -d. -f2|cut -d/ -f2`.3tnm
#	done
}

