# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/nslu2-sources/nslu2-sources-2.6.20.ebuild,v 1.1 2007/02/12 03:24:42 kolla Exp $

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
ETYPE="sources"

inherit kernel-2 subversion
detect_version

DESCRIPTION="Linux kernel sources with NSLU2 patches"
HOMEPAGE="http://www.kernel.org
          http://svn.nslu2-linux.org/svnroot/kernel"
SRC_URI="${KERNEL_URI}"

KEYWORDS="~arm"
S=${S}-nslu2

src_unpack() {
	unpack ${A}
	mv ${S/-nslu2/} ${S}

	mkdir ${S}/patches
	local repo="http://svn.nslu2-linux.org/svnroot/kernel/trunk/patches"
	S=${S}/patches subversion_fetch ${repo}/${PV}

	sed '/^#/d;/^$/d' ${S}/patches/series |
	while read line ; do
		EPATCH_OPTS="-p1 -d ${S}" epatch ${S}/patches/${line}
	done
}
