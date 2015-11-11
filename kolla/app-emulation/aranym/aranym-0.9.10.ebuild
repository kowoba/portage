# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/aranym/aranym-0.9.10.ebuild,v 1.1 2010/09/01 15:00:03 xmw Exp $

EAPI=2

inherit flag-o-matic eutils

DESCRIPTION="Atari Running on Any Machine, a VM running Atari ST/TT/Falcon OS and TOS/GEM applications"
HOMEPAGE="http://aranym.sourceforge.net/"
SRC_URI="mirror://sourceforge/aranym/${P}.tar.gz
	mirror://sourceforge/aranym/afros812.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="opengl ethernet nodsp rtc linux-m68k"

RDEPEND="media-libs/libsdl
	games-emulation/emutos
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_configure() {
	filter-flags -mpowerpc-gfxopt

	use opengl    && myconf="--enable-opengl"
	use ethernet  && mycomf="${myconf} --enable-ethernet"
	use nodsp     && myconf="${myconf} --enable-dsp=no"
	use rtc       && myconf="${myconf} --enable-rtctimer"
	if [[ ${ARCH} == x86 ]]; then
		if use linux-m68k ; then 
			myconf="${myconf} --enable-lilo --enable-fullmmu"
		else
			myconf="${myconf} --enable-jit-compiler"
		fi
	fi

	econf ${myconf} || die "configure failed"
	emake || die "failed during compilation"
}

src_install() {
	emake DESTDIR="${D}" INSTALL_PROGRAM="install" install || die "installation failed"

	insinto /usr/share/${PN}
	doins -r "${WORKDIR}"/afros || die

	dodoc "${D}"/usr/share/doc/${PN}/* || die
	rm -r "${D}"/usr/share/doc/${PN} || die
}

pkg_postinst() {
	elog "To run ARAnyM with AFROS type: aranym --config /usr/share/aranym/afros/config"
}
