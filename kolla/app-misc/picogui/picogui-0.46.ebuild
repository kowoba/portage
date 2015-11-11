# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/twin/twin-0.4.6.ebuild,v 1.4 2004/06/28 13:00:58 vapier Exp $

DESCRIPTION="A GUI architecture for embedded as well as desktops."
HOMEPAGE="http://www.picogui.org/"
SRC_URI="mirror://sourceforge/pgui/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"
IUSE="ggi gpm"

DEPEND="ggi? ( >=media-libs/libggi-1.9 )
	gpm? ( >=sys-libs/gpm-1.19.3 )"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	emake -j1 || die
}

src_install() {
	make install DESTDIR=${D} || die
}
