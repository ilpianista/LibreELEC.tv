# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="flac"
PKG_VERSION="1.3.4"
PKG_SHA256="8ff0607e75a322dd7cd6ec48f4f225471404ae2730d0ea945127b1355155e737"
PKG_LICENSE="GPLv2"
PKG_SITE="https://xiph.org/flac/"
PKG_URL="https://downloads.xiph.org/releases/flac/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libogg"
PKG_LONGDESC="An Free Lossless Audio Codec."
PKG_TOOLCHAIN="autotools"
# flac-1.3.1 dont build with LTO support
PKG_BUILD_FLAGS="+pic"

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-rpath \
                           --disable-altivec \
                           --disable-doxygen-docs \
                           --disable-thorough-tests \
                           --disable-cpplibs \
                           --disable-xmms-plugin \
                           --disable-oggtest \
                           --with-ogg=${SYSROOT_PREFIX}/usr \
                           --with-gnu-ld"

if target_has_feature sse; then
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-sse"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-sse"
fi

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
}
