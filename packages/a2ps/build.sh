TERMUX_PKG_HOMEPAGE=https://github.com/mtoyoda/sl
TERMUX_PKG_DESCRIPTION="Tool curing your bad habit of mistyping"
TERMUX_PKG_VERSION=4.14
TERMUX_PKG_SRCURL=https://github.com/mtoyoda/sl/archive/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=1e5996757f879c81f202a18ad8e982195cf51c41727d3fea4af01fdcbbb5563a
TERMUX_PKG_DEPENDS="gperf"
TERMUX_PKG_BUILD_IN_SRC=yes

termux_step_pre_configure () {
      cp $TERMUX_PREFIX/share/automake-`automake --version |grep automake|cut -d' ' -f4`/config.guess ./auxdir/
} 
