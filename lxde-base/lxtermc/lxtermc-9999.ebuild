# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools xdg

DESCRIPTION="Fork of the lightweight vte-based tabbed terminal emulator for LXDE - new config scheme"
# HOMEPAGE="https://wiki.lxde.org/en/LXTerminal"
# SRC_URI="https://github.com/philostone/${PN}/archive/refs/tags/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
RESTRICT="mirror fetch"

SRC_LOCAL_DIR="/home/ste/programming/github/lxtermc/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~mips ~ppc ~riscv ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
	dev-libs/glib:2
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/pango
	x11-libs/vte:2.91
"

BDEPEND="
	>=dev-util/intltool-0.40.0
	sys-devel/gettext
	virtual/pkgconfig
"

pkg_nofetch() {
	einfo "files are copied individually from local storage..."
}

src_unpack() {
	rsync -avC --exclude=".termpids" --exclude="files.list" --exclude="stored-unused" "${SRC_LOCAL_DIR}" "${WORKDIR}/${P}/"
}

src_prepare() {
#	eapply "${FILESDIR}/${P}-config.patch"
#	eapply_user
	xdg_src_prepare

	# Avoid maintainer mode, bug #818211
	rm aclocal.m4 || die

	eautoreconf
}

src_configure() {
	econf --enable-man --enable-gtk3
}
