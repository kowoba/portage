# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mixxx/mixxx-1.6.0-r1.ebuild,v 1.2 2008/12/02 06:17:27 ssuominen Exp $

EAPI=2

inherit eutils

MY_P=${P/_/-}

DESCRIPTION="a QT based Digital DJ tool"
HOMEPAGE="http://mixxx.sourceforge.net"
SRC_URI="http://downloads.mixxx.org/${MY_P}/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug djconsole hifieq ladspa recording shout +mp4 +vinylcontrol"

RDEPEND="media-libs/mesa
	media-libs/libmad
	media-libs/libid3tag
	media-libs/libvorbis
	media-libs/libsndfile
	>=media-libs/portaudio-19_pre
	djconsole? ( media-libs/libdjconsole )
	shout? ( media-libs/libshout )
	ladspa? ( media-libs/ladspa-sdk )
	mp4? ( media-libs/libmp4v2
		media-libs/faad2 )
	virtual/glu
	|| ( ( x11-libs/qt-core
		x11-libs/qt-gui
		x11-libs/qt-opengl )
		=x11-libs/qt-4.3*:4[opengl,qt3support] )"
DEPEND="${RDEPEND}
	dev-util/scons
	dev-util/pkgconfig"

S=${WORKDIR}/${P/_/\~}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:-O3::g' lib/cmetrics/SConscript || die "sed failed."
}

src_configure() {
	myconf="optimize=0 ffmpeg=0 script=0 prefix=/usr"

	use djconsole && myconf+=" djconsole=1" || myconf+=" djconsole=0"
	use hifieq && myconf+=" hifieq=1" || myconf+=" hifieq=0"
	use debug && myconf+=" cmetrics=1" || myconf+=" cmetrics=0"
	use shout && myconf+=" shoutcast=1" || myconf+=" shoutcast=0"
	use ladspa && myconf+=" ladspa=1" || myconf+=" ladspa=0"
	use mp4 && myconf+=" m4a=1" || myconf+=" m4a=0"
	use recording && myconf+=" experimentalrecord=1" || myconf+=" experimentalrecord=0"
	use vinylcontrol && myconf+=" vinylcontrol=1" || myconf+=" vinylcontrol=0"

	$(type -P scons) ${myconf} -c . || die "scons -c . failed."
}

src_compile() {
	$(type -P scons) ${myconf} || die "scons failed."
}

src_install() {
	dobin mixxx || die "dobin failed."

	insinto /usr/share/mixxx
	doins -r src/{skins,midi,keyboard} || die "doins failed."

	doicon src/mixxx-icon.png
	domenu src/mixxx.desktop

	dodoc HERCULES.txt README*

	insinto /usr/share/doc/${PF}
	doins Mixxx-Manual.pdf
}
