# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion autotools

DESCRIPTION="A TB-303 DSSI plugin for Linux"
HOMEPAGE="http://www.nekosynth.co.uk/wiki/nekobee"
ESVN_REPO_URI="svn://www.nekosynth.co.uk/nekosynth/${PN}/trunk"
SRC_URI=""

S=${WORKDIR}/trunk

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/dssi
	    media-libs/liblo
	    >=x11-libs/gtk+-2"
RDEPEND="${DEPEND}"

src_unpack() {
	subversion_src_unpack
	eautoreconf
	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
