# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/twin/twin-0.4.6.ebuild,v 1.4 2004/06/28 13:00:58 vapier Exp $

MY_P=${P/_beta1/-beta}
S=${WORKDIR}/${PN/x/}-${PV/_beta1}

DESCRIPTION="TimeTracker is an Athena Widget-based program to keep track of time"
HOMEPAGE="http://www.alvestrand.no/titrax/"
SRC_URI="http://www.alvestrand.no/titrax/${MY_P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~beta ~hppa ~amd64 ~ia64"

DEPEND="x11-misc/imake
        dev-lang/tcl
        dev-lang/tk"

RDEPEND="dev-lang/tcl
        dev-lang/tk"

src_unpack() {
	unpack ${A}
	sed 's:^NONXBINDIR = .*:NONXBINDIR = /usr/bin:' -i ${S}/Imakefile
	sed 's:^PERLLIBDIR = .*:PERLLIBDIR = /usr/lib/perl5:' -i ${S}/Imakefile
	sed 's:tail +2:tail -n +2:g' -i ${S}/Imakefile
	sed 's:Alpha:Beta:g' -i ${S}/patchlevel.h
	cd ${S}
}

src_compile() {
	xmkmf
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
}
