# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

#DESCRIPTION="Desktop dashboard (conky-like) for flip notebook - (initially) ASUS Expert Book B7"
# HOMEPAGE="https://wiki.lxde.org/en/LXTerminal"
# SRC_URI="https://github.com/philostone/${PN}/archive/refs/tags/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
RESTRICT="mirror fetch"

SRC_LOCAL_DIR="/home/ste/programming/github/text-view/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~mips ~ppc ~riscv ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# ste - vte 2.91 gtk -> gtk:4
DEPEND="
	dev-libs/glib:2
	x11-libs/gdk-pixbuf:2
	gui-libs/gtk:4
	gui-libs/vte:2.91-gtk4
	x11-libs/libX11
	x11-libs/pango
"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

pkg_nofetch() {
	einfo "files are copied individually from local storage..."
}

src_unpack() {
	rsync -avC --exclude=".termpids" --exclude="files.list" --exclude=".git" \
		"${SRC_LOCAL_DIR}" "${WORKDIR}/${P}/"
}

#src_prepare() {
#	eapply "${FILESDIR}/${P}-config.patch"
#	eapply_user
#	xdg_src_prepare

	# Avoid maintainer mode, bug #818211
#	rm aclocal.m4 || die

#	eautoreconf
#}

src_configure() {
# ste - disable-nls until we get things working, only gtk4
#	econf --enable-man --enable-gtk3 --disable-nls
#	econf --enable-man --disable-nls
	meson_src_configure
}

src_install() {
	meson_src_install
}
