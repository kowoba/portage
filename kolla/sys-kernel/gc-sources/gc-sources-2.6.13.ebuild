# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gc-sources/gc-sources-2.6.12.5.ebuild,v 1.1 2005/08/20 13:05:05 chrb Exp $

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE='sources'
inherit kernel-2
detect_arch
detect_version

# version of gentoo patchset
GC_PATCHES=linux-${PV}-gc.patch.gz

KEYWORDS="~ppc -*"
UNIPATCH_LIST="
	${ARCH_PATCH}
	${DISTDIR}/${GC_PATCHES}
	${FILESDIR}/gc-fbsplash-0.9.2-r4.patch"
UNIPATCH_STRICTORDER="yes"
DESCRIPTION="Full sources for the GameCbe Linux kernel"
SRC_URI="${KERNEL_URI}
	${ARCH_URI}
	mirror://sourceforge/gc-linux/${GC_PATCHES}"

src_install() {
	mv ${S} ${S}-gc
	kernel-2_src_install
}

