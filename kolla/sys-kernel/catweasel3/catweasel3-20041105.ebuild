# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /usr/local/portage/sys-kernel/catweasel/catweasel-20040211 $

inherit eutils 

DESCRIPTION="CatWeasel kernel drivers"
HOMEPAGE="http://llg.cubic.org/cw/"
SRC_URI="http://llg.cubic.org/cw/cw-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

KMOD_SOURCES="none"

S="${WORKDIR}/cw-${PV}"

src_unpack() {
	unpack ${A} || die "unpack failed"
	epatch ${FILESDIR}/${P}_patch || die "patch failed"
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	# The driver goes into the standard modules location
	insinto /lib/modules/${KV}/extra

	# Insert the module
	doins device/cw.ko

	# Docs
	dodoc INSTALL COPYING NEWS README TODO parameters.txt
}
