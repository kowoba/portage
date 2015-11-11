# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libupnp/libupnp-1.6.0.ebuild,v 1.1 2007/06/29 12:36:56 gurligebis Exp $

WANT_AUTOMAKE=1.9

DESCRIPTION="An Open Source DLNA (Digital Living Network Alliance) implementation"
HOMEPAGE="http://libdlna.geexbox.org/"
SRC_URI="http://libdlna.geexbox.org/releases/${P}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

src_compile() {
	./configure --prefix=/usr --enable-shared || die
	emake || die
}

src_install () {
	dodir /usr/lib || die
	dolib.so src/libdlna.so.0.2.3 || die
	dodoc AUTHORS README ChangeLog COPYING || die
}
