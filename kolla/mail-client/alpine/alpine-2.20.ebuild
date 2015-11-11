# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit eutils flag-o-matic autotools multilib toolchain-funcs

CHAPPA_PL=115
DESCRIPTION="alpine is an easy to use text-based based mail and news client"
HOMEPAGE="http://www.washington.edu/alpine/ http://patches.freeiz.com/alpine/"
SRC_URI="http://patches.freeiz.com/alpine/release/src/${P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc ipv6 kerberos ldap nls onlyalpine passfile smime spell ssl threads"

DEPEND=">=sys-libs/ncurses-5.1
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	kerberos? ( app-crypt/mit-krb5 )
	spell? ( app-text/aspell )"
RDEPEND="${DEPEND}
	app-misc/mime-types
	!onlyalpine? ( !mail-client/pine )
	!<=net-mail/uw-imap-2004g"

src_prepare() {
	epatch "${FILESDIR}"/2.00-lpam.patch
	epatch "${FILESDIR}"/2.00-qa.patch

	eautoreconf
}

src_configure() {
	local myconf="--without-tcl
		--with-system-pinerc=${EPREFIX}/etc/pine.conf
		--with-system-fixed-pinerc=${EPREFIX}/etc/pine.conf.fixed"
		#--disable-debug"
		# fixme
		#   --with-system-mail-directory=DIR?

	if use ssl; then
		myconf+=" --with-ssl
			--with-ssl-include-dir=${EPREFIX}/usr/include/openssl
			--with-ssl-lib-dir=${EPREFIX}/usr/$(get_libdir)
			--with-ssl-certs-dir=${EPREFIX}/etc/ssl/certs"
	else
		myconf+="--without-ssl"
	fi
	econf \
		$(use_with ldap) \
		$(use_with passfile passfile .pinepwd) \
		$(use_with kerberos krb5) \
		$(use_with threads pthread) \
		$(use_with spell interactive-spellcheck ${EPREFIX}/usr/bin/aspell) \
		$(use_enable nls) \
		$(use_with ipv6) \
		${myconf}
}

src_compile() {
	emake AR=$(tc-getAR)
}

src_install() {
	if use onlyalpine ; then
		dobin alpine/alpine
		doman doc/alpine.1
	else
		emake DESTDIR="${D}" install
		doman doc/rpdump.1 doc/rpload.1
	fi

	dodoc NOTICE README*

	if use doc ; then
		dodoc doc/brochure.txt doc/tech-notes.txt

		docinto html/tech-notes
		dohtml -r doc/tech-notes/
	fi
}
