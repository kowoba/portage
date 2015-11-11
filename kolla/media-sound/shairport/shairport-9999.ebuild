# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

# No package file are provided so need to get the source directly from git.
EGIT_REPO_URI="git://github.com/albertz/shairport.git"
EGIT_COMMIT="master"

inherit eutils git-2

DESCRIPTION="Airtunes emulation library"
HOMEPAGE="http://mafipulation.org"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-libs/openssl
	media-libs/libao";
RDEPEND="${DEPEND}"

src_prepare() {
#	epatch "${FILESDIR}/001_add_ao.patch"
#	epatch "${FILESDIR}/002_fix_install_header.patch"
#	epatch "${FILESDIR}/003_fix_deadlock.patch"
#	epatch "${FILESDIR}/004_fix_bad_access.patch"
#	epatch "${FILESDIR}/005_fix_shutdown.patch"
#	epatch "${FILESDIR}/006_no_printf.patch"
#	epatch "${FILESDIR}/007_fix_syslog_defines.patch"
#	epatch "${FILESDIR}/008-add-missing-libs.patch"
	eautoreconf -vif
}

