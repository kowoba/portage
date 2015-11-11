# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_V=${PV//.}

DESCRIPTION="REBOL - View"
HOMEPAGE="http://www.rebol.com/"
SRC_URI="http://www.rebol.com/downloads/v${MY_V}/rebview-ppc.gzip"

LICENSE="Commercial"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	mkdir -p ${S}
	cd ${S}
	unpack ${A}
}

src_install() {
	dodoc setup.html feedback.r license.html
	dobin rebol
}
