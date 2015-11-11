# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /usr/portage/local/kolla/sys-libs/pam_shield/pam_shield-0.9.2.ebuild 1.1 2008/05/19 03:53:01 kolla Exp $

inherit eutils

DESCRIPTION="PAM module that uses null-routing or iptables to lock out attackers"
SRC_URI="http://www.heiho.net/pam_shield/${P}.tar.gz"
HOMEPAGE="http://www.heiho.net/pam_shield"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~m68k ~arm ~x86 ~ppc ~sparc ~alpha ~mips ~amd64"

DEPEND="sys-libs/gdbm
	sys-libs/pam"

RDEPEND="${DEPEND}"

src_compile() {
	emake || die "make failed"
}

src_install() {
	dodir /lib/security
	dodir /usr/sbin
	dodir /etc/cron.daily
	dodir /etc/security
	dodir /var/lib/pam_shield

	insinto /lib/security
	doins pam_shield.so

	insinto /usr/sbin
	insopts -m0700
	doins shield-purge shield-trigger.sh

	insinto /etc/cron.daily
	doins pam_shield.cron

	insinto /etc/security
	doins shield.conf

	keepdir /var/lib/pam_shield

	dodoc CREDITS  INSTALL   README
}

pkg_postinst() {
	einfo ""
	einfo "Edit the config file /etc/security/shield.conf and make sure all paths are correct."
	einfo "Also, create an 'allow' line for your local networks. (If you do notlist your local"
	einfo "networks, a local user may be able to lock you out (DoS attack))."
	einfo ""
	einfo "Add the line below to services in /etc/pam.d/sshd"
	einfo ""
	einfo "      auth optional   pam_shield.so"
	einfo ""
}

