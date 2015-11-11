# Copyright 1999-2005 Gentoo Foundation.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/apache/apache-2.0.52-r3.ebuild,v 1.9 2005/02/13 05:00:13 vericgar Exp $

DESCRIPTION="Use your T610 as a remote for you Linux PC."
HOMEPAGE="http://www.geocities.com/saravkrish/progs/bluemote/"
SRC_URI="http://www.geocities.com/saravkrish/progs/${PN}/${P/-/.}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~m68k"
S=${WORKDIR}/${PN}


src_install() {
	dobin bluemote
	dodoc README COPYING AUTHOR bluemote-example.cfg config.txt
}
