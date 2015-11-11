# Copyright 1999-2005 Gentoo Foundation.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/apache/apache-2.0.52-r3.ebuild,v 1.9 2005/02/13 05:00:13 vericgar Exp $

DESCRIPTION="BlueTooth Caller ID"
HOMEPAGE="http://0x63.nu/"
SRC_URI="http://0x63.nu/files/${PN}/${P}.tgz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~m68k"


src_install() {
	dobin btcid
	dodoc README COPYING
}
