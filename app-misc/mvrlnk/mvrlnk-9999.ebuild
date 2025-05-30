# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#inherit meson xdg
inherit meson

DESCRIPTION="Move and relink files"
# HOMEPAGE="https://wiki.lxde.org/en/LXTerminal"
# SRC_URI="https://github.com/philostone/${PN}/archive/refs/tags/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
RESTRICT="mirror fetch"

SRC_LOCAL_DIR="/home/ste/programming/github/mvrlnk/"
EBUILD_EXCLUDE="${SRC_LOCAL_DIR}ebuild.exclude"

# ste - for local (copy) build setup, the file ebuild.exclude typically include (at least):
#	ebuild.exclude
#	.termpids
#	files.list

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~mips ~ppc ~riscv ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# ste - vte 2.91 gtk -> gtk:4
#DEPEND="
#	x11-libs/libX11
#"
BDEPEND="
	virtual/pkgconfig
"
#	sys-devel/gettext

pkg_nofetch() {
	einfo "files are copied individually from local storage..."
}

# rsync -avC (old setup) -> rsync -rlptgoDvC (a = rlptgoD)
# -v : verbose
# -r : recurse
# -l : copy symlinks as is -> use -L to follow symlinks
# -ptgo : preserve permissions, modification times, group, owner
# -D : preserve device and special files (super user only) -> skip this
# -C : exclude CVS, should exclude .git...
src_unpack() {
	rsync -vrLptgoC --exclude-from="${EBUILD_EXCLUDE}" "${SRC_LOCAL_DIR}" "${WORKDIR}/${P}/"
}

# old implementation
#src_unpack() {
#	rsync -vrptgoCL --exclude=".termpids" --exclude="files.list" --exclude=".git" \
#		"${SRC_LOCAL_DIR}" "${WORKDIR}/${P}/"
#}

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
