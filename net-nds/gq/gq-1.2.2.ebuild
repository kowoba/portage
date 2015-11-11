# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/www/viewcvs.gentoo.org/raw_cvs/gentoo-x86/net-nds/gq/Attic/gq-1.0_beta1-r1.ebuild,v 1.5 2006/03/26 06:18:24 halcy0n dead $

inherit eutils

S=${WORKDIR}/${PN}-${PV/_/}
DESCRIPTION="GTK-based LDAP client"

SRC_URI="mirror://sourceforge/gqclient/${PN}-${PV/_/}.tar.gz"
HOMEPAGE="http://www.biot.com/gq/"
IUSE="kerberos jpeg nls ssl gnome"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc ~x86"

RDEPEND=">=x11-libs/gtk+-2
	>=net-nds/openldap-2
	kerberos? ( app-crypt/mit-krb5 )
	jpeg? ( media-libs/gdk-pixbuf )
	ssl? ( dev-libs/openssl )
	dev-libs/libxml2
	dev-libs/glib
	sys-devel/gettext
	=dev-libs/atk-1*
	x11-libs/pango
	dev-libs/cyrus-sasl
	virtual/libc"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-apps/gawk
	sys-devel/bison
	sys-devel/gcc
	gnome? ( gnome-base/gnome-keyring )
	"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die

	# Fix timestamp skews
	touch aclocal.m4 configure `find . -name Makefile.in`

	if use amd64 ; then
		rm config.sub config.guess
		automake --add-missing --copy
	fi
}

src_compile() {
	local myconf="--enable-browser-dnd --enable-cache --enable-update-mimedb=no"

	use nls \
		&& myconf="${myconf} --with-included-gettext" \
		|| myconf="${myconf} --disable-nls"

	use kerberos && myconf="${myconf} --with-kerberos-prefix=/usr"

	use gnome && myconf="${myconf} --with-keyring-api=gnome"

	econf $myconf || die "./configure failed"

	emake || die "Compilation failed"
}

src_install() {
	emake DESTDIR=${D} install || die "Installation failed"
	rm -f ${D}/usr/share/locale/locale.alias
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING NEWS README* TODO
}

pkg_postinst() {
	einfo "Updating MIME database..."
	update-mime-database /usr/share/mime
	einfo "Done"
}

