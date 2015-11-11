# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Allows you to send edonkey links to mldonkey by clicking on the link from within the browser"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://www.ml81.dyndns.org/~tux/projekte/qsubmit"
SRC_URI="http://www.ml81.dyndns.org/~tux/projekte/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=net-p2p/mldonkey-2.5.16 \
	 >=x11-libs/qt-4.1.0"
S=${WORKDIR}/${P}/src

src_compile() {
	qmake || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin ${S}/qsubmit || die "dobin ${S}/qsubmit failed"
	insinto /usr/share/${PN}/translations/
	doins ${S}/qsubmit_*.qm || die "insinto translations failed"
}

pkg_postinst() {
	einfo ""
	einfo "The installation of qsumbit is now complete."
	einfo "Browser integration"
	einfo "--------------------"
	einfo "Firefox and Mozilla:"
	einfo "Launch Firefox or Mozilla and enter about:config into the"
	einfo "adressbar and hit 'return'."
	einfo "Now, create a boolean and a string value by rightclicking"
	einfo "and choosing 'New' -> 'Boolean' and 'New' -> 'String' respectively."
	einfo "Name the boolean: network.protocol-handler.external.ed2k and set"
	einfo "it to true"
	einfo "Name the string: network.protocol-handler.app.ed2k and set it to "
	einfo "/usr/local/bin/qsubmit"
	einfo ""
	einfo "Opera:"
	einfo "From the menu choose 'Tools' -> 'Preferences' -> 'Advanced'"
	einfo "Choose programs from the entries displayed on the left panel"
	einfo "In 'choose helper applications for other protocols' click 'Add'"
	einfo "For 'Protocol' enter: ed2k"
	einfo "For 'Choose another application' enter the path to the qsubmit"
	einfo "binary. It is generally located at /usr/bin/qsubmit."
	einfo ""
	einfo "Konqueror:"
	einfo "Create a file 'ed2k.protocol' with following content:"
	einfo "[Protocol]"
	einfo "exec=/usr/local/bin/qsubmit \"%u\""
	einfo "protocol=ed2k"
	einfo "input=none"
	einfo "output=none"
	einfo "helper=true"
	einfo "listing=false"
	einfo "reading=false"
	einfo "writing=false"
	einfo "makedir=false"
	einfo "deleting=false"
	einfo ""
	einfo "and place it under /usr/kde/<YOUR_KDE_VERSION>/share/services"
	einfo "e.g. /usr/kde/3.4/share/services"
	einfo ""
}