# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Xbox Media Streaming Daemon"
HOMEPAGE="http://xbmsd.sourceforge.net"
SRC_URI="mirror://sourceforge/xbmsd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# xbmsd should work on all platforms but only x86 is tested by the author
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~s390 ~sh ~sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="virtual/libc"

src_install() {
	make DESTDIR=${D} install || die
	newinitd ${FILESDIR}/xbmsd.initrc xbmsd
}

pkg_preinst() {
	# The configuration file in the source distribution is just an
	# example, don't install it if a configuration file already
	# exists to avoid unnecessary etc-updates.
	if [[ -e "${ROOT}/etc/xbmsd/xbmsd.conf" ]]; then
		rm ${IMAGE}/etc/xbmsd/xbmsd.conf
	fi
}
