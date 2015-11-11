# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /usr/portage/local/kolla/sys-libs/pam_radius/pam_radius-1.3.17.ebuild 1.1 2008/02/12 07:53:01 kolla Exp $

inherit eutils

DESCRIPTION="The PAM RADIUS authentication module"
SRC_URI="ftp://ftp.freeradius.org/pub/freeradius/${P}.tar.gz"
HOMEPAGE="http://www.freeradius.org/pam_radius_auth/"

IUSE="pam ssl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~amd64"

RDEPEND="sys-libs/pam"
DEPEND="ssl? ( dev-libs/openssl )
	sys-libs/pam"

src_compile() {
	emake || die "make failed"
	mv pam_radius_auth.conf server
}

src_install() {
	dodir /lib/security /etc/raddb
	dodir /etc/pam.d

	insinto /lib/security
	doins pam_radius_auth.so

	insinto /etc/raddb
	insopts -m0600
	doins server

	dodoc Changelog INSTALL LICENSE README TODO USAGE index.html
}
