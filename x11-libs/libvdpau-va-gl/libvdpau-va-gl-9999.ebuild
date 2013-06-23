# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils multilib git-2

DESCRIPTION="VDPAU driver with VA-API/OpenGL backend."
HOMEPAGE="https://github.com/i-rinat/libvdpau-va-gl/"
EGIT_REPO_URI="git://github.com/i-rinat/libvdpau-va-gl.git"

LICENSE="LGPL-3"
SLOT="0"

KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-libs/glib:2
	x11-libs/libva[X,opengl]
	x11-libs/libvdpau
	x11-libs/libX11
	x11-libs/libXext
	media-libs/glu
	virtual/opengl
	virtual/ffmpeg
"
DEPEND="${RDEPEND}"

DOCS=(ChangeLog README.md)

RESTRICT="test"

src_prepare() {
	cmake-utils_src_prepare
	sed -e '/add_definitions/s, -ggdb,,' -i CMakeLists.txt || die
	sed -e "/^install /s, lib/, $(get_libdir)/," -i CMakeLists.txt || die
}

pkg_postinst() {
	einfo "In order to use vdpau hardware video acceleration via ${PN}"
	einfo "you have to add VDPAU_DRIVER=va_gl to your environment"
}
