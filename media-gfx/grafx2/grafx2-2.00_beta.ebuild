# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A pixelart-oriented painting program"
HOMEPAGE="http://code.google.com/p/grafx2/"
SRC_URI="http://grafx2.googlecode.com/files/${PN}-2.00b99.0-svn745-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ttf"

DEPEND="virtual/libc
	media-libs/libsdl
	media-libs/sdl-image
	ttf? (
		media-libs/freetype
		media-libs/sdl-ttf
	)"
RDEPEND=""

src_unpack() {
	unpack ${A}
	sed 's:^  prefix = .*:  prefix = /usr:' ${S}/Makefile
}

src_compile() {
	use ttf || MYCNF="NOTTF=1"
	emake ${MYCNF} || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe grafx2
	
	insinto /usr/share/${PN}
	doins gfx2.gif gfx2def.ini gfx2.ico
	insinto /usr/share/${PN}/skins
	doins skins/*
	insinto /usr/share/${PN}/fonts
	doins fonts/*
	
	newicon gfx2.gif ${PN}.gif
	make_desktop_entry ${PN} "Grafx2" ${PN}.gif "Graphics"
}
