# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/inspircd/inspircd-1.0.7-r1.ebuild,v 1.2 2007/01/04 18:51:12 hansmi Exp $

inherit eutils toolchain-funcs multilib

IUSE="openssl gnutls ipv6"

DESCRIPTION="InspIRCd - The Modular C++ IRC Daemon"
HOMEPAGE="http://www.inspircd.org"
SRC_URI="mirror://sourceforge/${PN}/InspIRCd-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86 m68k"
RDEPEND="
	openssl? ( >=dev-libs/openssl-0.9.7d )
	gnutls? ( >=net-libs/gnutls-1.3.0 )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/inspircd"

pkg_setup() {
	enewgroup inspircd
	enewuser inspircd -1 -1 -1 inspircd
}

# Determines the appropriate value for the
# GCC34= configuration option.
inspircd-determine-gcc34() {
	if [[ $(gcc-major-version) -gt 3 ]] ; then
		echo "4"
	else
		if [[ $(gcc-minor-version) -lt 4 ]] ; then
			echo "3"
		else
			echo "4"
		fi
	fi
}

src_compile() {
	local myconf="--binary-dir=/usr/bin
	--config-dir=/etc/inspircd
	--module-dir=/usr/$(get_libdir)/inspircd/modules
	--library-dir=/usr/$(get_libdir)/inspircd"

	# Write a configuration file
	einfo "Building configuration parameters file."

	if use openssl; then
		einfo "Enabling OpenSSL SSL engine module."
		myconf="${myconf} --enable-openssl"
	fi

	if use gnutls; then
		einfo "Enabling GnuTLS SSL engine module."
		myconf="${myconf} --enable-gnutls"
	fi

	if use ipv6; then
		einfo "Enabling GnuTLS SSL engine module."
		myconf="${myconf} --enable-ipv6"
	fi

	# build makefiles based on our configure params
	# Please note that it's not the autoconf configure script, thus
	# we don't use econf.
	econf ${myconf}  || die "configure failed"
	emake DESTDIR="${D}" || die "emake failed"
}

src_install() {
	# the inspircd buildsystem does not create these, it's configure script
	# does. so, we have to at this point to make sure they are there.
	dodir /usr/$(get_libdir)/inspircd
	dodir /usr/$(get_libdir)/inspircd/modules
	dodir /etc/inspircd
	dodir /usr/bin/ircd

	emake \
		LIBPATH="${D}/usr/$(get_libdir)/inspircd" \
		MODPATH="${D}/usr/$(get_libdir)/inspircd/modules" \
		CONPATH="${D}/etc/inspircd" \
		BINPATH="${D}/usr/bin" \
		BASE="${D}/usr/bin/inspircd.launcher" \
		install

	newinitd "${FILESDIR}"/init.d_inspircd inspircd
}

pkg_postinst() {
	chown -R inspircd:inspircd "${ROOT}"/etc/inspircd
	chmod 700 "${ROOT}"/etc/inspircd

	chown -R inspircd:inspircd "${ROOT}"/usr/$(get_libdir)/inspircd
	chmod -R 755 "${ROOT}"/usr/$(get_libdir)/inspircd

	chmod -R 755 /usr/bin/inspircd
}
