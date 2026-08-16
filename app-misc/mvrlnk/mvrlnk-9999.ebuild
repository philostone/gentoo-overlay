# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="Move and relink files"
# HOMEPAGE="https://philostone.github.io"
# SRC_URI="https://github.com/philostone/${PN}/archive/refs/tags/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
RESTRICT="mirror fetch"

SRC_LOCAL_DIR="/home/ste/programming/github/mvrlnk/"
EBUILD_EXCLUDE="${SRC_LOCAL_DIR}ebuild.exclude"

# ste - for local (copy) build setup, the file ebuild.exclude typically includes (at least):
#	ebuild.exclude
#	.termpids
#	files.list

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

BDEPEND="
	virtual/pkgconfig
"

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

src_configure() {
#	use debug && EMESON_BUILDTYPE=debug
	if use debug ; then
		filter-flags -O2
		append-flags -g -ggdb
		append-ldflags -g -ggdg
		EMESON_BUILDTYPE=debug
	fi
	local emesonargs=(
		$(meson_use debug)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
}
