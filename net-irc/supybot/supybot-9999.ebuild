# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/supybot/supybot-9999.ebuild,v 1.2 2008/02/20 19:57:30 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit git-2 distutils

MY_P=${P/supybot/Supybot}
MY_P=${MY_P/_rc/rc}

DESCRIPTION="Python based extensible IRC infobot and channel bot"
HOMEPAGE="http://supybot.com/"
SRC_URI=""

EGIT_PROJECT="supybot"
EGIT_REPO_URI="git://supybot.git.sourceforge.net/gitroot/supybot/${EGIT_PROJECT}"
EGIT_BRANCH="master"
EGIT_COMMIT="${EGIT_BRANCH}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="sqlite"

DEPEND=">=dev-python/twisted-1.2.0
	sqlite? ( <dev-python/pysqlite-1.1 )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

DOCS="ACKS RELNOTES docs/*"

src_unpack() {
	git-2_src_unpack
}

src_install() {
	distutils_src_install
}

pkg_postinst() {
	distutils_pkg_postinst
	elog "Use supybot-wizard to create a configuration file"
	use sqlite || \
		elog "Some plugins may require emerge with USE=\"sqlite\" to work."
}
