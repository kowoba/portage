# Copyright 1999-2005 Gentoo Foundation.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/caudium/caudium-1.4.8.ebuild,v 1.9 2005/02/13 05:00:13 vericgar Exp $

inherit eutils flag-o-matic gnuconfig autotools

DESCRIPTION="Caudium is a web server based on the Roxen Challenger 1.3."
HOMEPAGE="http://www.cadium.org"
SRC_URI="ftp://ftp.${PN}.net/${PN}/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE="truetype xsl ssl"

RDEPEND="dev-lang/pike
	dev-libs/libpcre
	app-misc/mime-types
	sys-libs/zlib
	ssl? ( dev-libs/openssl )
	xsl? ( app-text/sablotron dev-libs/expat virtual/libiconv )
	truetype? ( <media-libs/freetype-2 )"

DEPEND="${RDEPEND}"


src_compile() {
	local myconf
	myconf="--prefix=/opt/caudium --with-pike=/usr/bin/pike"
	useq xsl || myconf="${myconf} --without-PiXSL"

	einfo "./configure ${myconf}"

	./configure ${myconf} || die "bad ./configure please submit bug report to bugs.gentoo.org. Include your config.layout and config.log"

	emake || die "problem compiling apache2"
}
