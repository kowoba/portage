# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/alpine/alpine-0.82.ebuild,v 1.1 2007/01/28 02:32:45 kolla Exp $

inherit eutils subversion autotools

DESCRIPTION="A tool for reading, sending and managing electronic messages."
HOMEPAGE="http://www.washington.edu/alpine/"
ESVN_REPO_URI="https://svn.cac.washington.edu/public/${PN}/snapshots"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~arm ~mips ~m68k"

IUSE="ssl ldap kerberos passfile debug"

DEPEND="virtual/libc
	>=sys-apps/sed-4
	>=sys-libs/ncurses-5.1
	pam? ( >=sys-libs/pam-0.72 )
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	kerberos? ( app-crypt/mit-krb5 )"

RDEPEND="${DEPEND}
	app-misc/mime-types
	net-mail/uw-mailutils
	!<=net-mail/uw-imap-2004g"

S=${WORKDIR}/snapshots

src_unpack() {
	subversion_src_unpack
	epatch ${FILESDIR}/re-alpine-2.01_openssl-fix_v3.patch
	AT_M4DIR="m4" eautoreconf
	elibtoolize
}

src_compile() {
	myconf=""
	use debug    && FEATURES="${FEATURES} nostrip" \
				myconf="--with-debug-level=2 --with-debug-files=4"
	use passfile && myconf="${myconf} --with-passfile=.alpinepw"
	use ssl      || myconf="${myconf} --without-ssl"
	use ldap     || myconf="${myconf} --without-ldap"
	use kerberos || myconf="${myconf} --without-krb5"

	econf ${myconf} || die "configure failed"
	emake || die "failed during compilation"
}

src_install() {
	dobin alpine/alpine pico/pico pico/pilot alpine/rpdump alpine/rpload

	# Only mailbase should install /etc/mailcap
#	donewins doc/mailcap.unx mailcap

	doman doc/alpine.1 doc/pico.1 doc/pilot.1 doc/rpdump.1 doc/rpload.1
	dodoc LICENSE NOTICE README doc/brochure.txt doc/tech-notes.txt
#	if use ipv6 ; then
#		dodoc "${DISTDIR}/readme.${P}-v6-20031001"
#	fi

	docinto imap
	dodoc imap/docs/*.txt imap/docs/CONFIG imap/docs/RELNOTES

	docinto imap/rfc
	dodoc imap/docs/rfc/*.txt

	docinto html/tech-notes
	dohtml -r doc/tech-notes/
}
