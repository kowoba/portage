# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils

DESCRIPTION="Radius/RadSec Proxy Server"
HOMEPAGE="http://software.uninett.no/radsecproxy"
SRC_URI="http://software.uninett.no/${PN}/${P/_rc/-rc}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~arm ~mips ~m68k"
IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND=${RDEPEND}

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
}

src_configure() {
	econf || die
}

src_install() {
	einstall || die
	newinitd "${FILESDIR}"/"${PN}".init ${PN}
	newconfd "${FILESDIR}"/"${PN}".conf ${PN}
	insinto /etc
	newins radsecproxy.conf-example radsecproxy.conf-example
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}

pkg_postinst () {
	einfo
	elog "Example config exists as /etc/radsecproxy.conf-example"
	elog "Copy this to /etc/radsecproxy.conf and edit to suit your needs"
	einfo
}
