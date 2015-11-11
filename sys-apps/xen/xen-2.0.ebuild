# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit mount-boot

DESCRIPTION="The Xen virtual machine monitor"
HOMEPAGE="http://xen.sourceforge.net"
SRC_URI="mirror://sourceforge/xen/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="sys-apps/iproute2
	net-misc/bridge-utils
	dev-lang/python
	>=dev-python/twisted-1.3.0
	net-misc/curl
	sys-libs/zlib
	doc? (
		dev-tex/latex2html
		media-gfx/transfig
		media-gfx/tgif
	)"

src_compile() {
	make xen || die
	make tools || die
	if use doc; then
		make docs || die
	fi

}

src_install() {
	make prefix=${D} -C xen install || die
	make prefix=${D} -C tools install || die
	if use doc; then
		make prefix=${D} -C docs install || die
		# Rename doc/xen to the Gentoo-style doc/xen-2.0
		mv ${D}/usr/share/doc/xen ${D}/usr/share/doc/${PF}
	fi
}
