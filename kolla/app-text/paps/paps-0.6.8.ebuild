# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/paps/paps-0.6.8.ebuild,v 1.7 2009/10/22 18:44:05 kolla Exp $

inherit eutils

DESCRIPTION="powerful text-to-postscript converter"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/paps/"

KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2"

DEPEND="x11-libs/pango"

src_unpack() {
	unpack ${A}
}

src_compile() {
	econf
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog COPYING.LIB INSTALL NEWS README TODO || die "dodoc failed"
}
