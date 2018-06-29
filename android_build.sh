#!/bin/sh
CWD=$(pwd)
VER=27
NDK="/home/uniqa/android-sdk/ndk-bundle/"
LIBS="/home/uniqa/eltex/root"
TC="$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/"
SYS="$NDK/platforms/android-$VER/arch-arm/"
FLAGS="--sysroot=$SYS"
export PATH="$PATH:$TC/bin/:./lol/"
export CFLAGS="$FLAGS "
export CPPFLAGS="$FLAGS -D__USE_FILE_OFFSET64=1 -DPTHREAD_CANCEL_DISABLE -DPTHREAD_CANCEL_ENABLE -Dpthread_setcancelstate= -DANDROID -D__ANDROID__ -D__ANDROID_API__=$VER -isysroot $NDK/sysroot/ -isystem $NDK/sysroot/usr/include/arm-linux-androideabi/ "
export LDFLAGS="$FLAGS -L$LIBS/lib/"
export CC="$CWD/cc_shim.py arm-linux-androideabi-gcc"
export AR=arm-linux-androideabi-ar
export CPP=arm-linux-androideabi-cpp
export NM=arm-linux-androideabi-nm
export LD=arm-linux-androideabi-ld.gold
export OBJDUMP=arm-linux-androideabi-objdump
export RANLIB=arm-linux-androideabi-ranlib
export PYTHON=/usr/bin/python2
export CROSS_COMPILE="$TC/bin/arm-linux-androideabi-"
#./makeconf.sh
./buildtools/bin/waf distclean
./configure --host=arm-linux-androideabi \
              --hostcc=/usr/bin/gcc \
              --cross-compile \
              --cross-answers=arm.txt \
              --bundled-libraries=ALL \
              --accel-aes=none \
              --enable-fhs \
              --without-gettext \
              --without-regedit \
              --without-dnsupdate \
              --without-fam \
              --disable-python \
              --without-gpgme \
              --without-ldap \
              --without-ads \
              --without-ad-dc \
              --without-dmapi \
              --without-acl-support \
              --without-utmp \
              --disable-cups \
              --disable-iprint \
              --disable-cephfs \
              --disable-glusterfs \
              --disable-avahi \
              --without-automount \
              --without-systemd \
              --disable-gnutls \
              --prefix=/usr \
              --sysconfdir=/etc \
              --sbindir=/usr/bin \
              --libdir=/usr/lib \
              --libexecdir=/usr/lib/samba \
              --localstatedir=/var \
              --with-configdir=/etc/samba \
              --with-lockdir=/var/cache/samba \
              --with-sockets-dir=/var/run/samba \
              --with-piddir=/var/run \
              --without-winbind \
              --without-pam \
              --disable-rpath-install

./buildtools/bin/waf build --targets=client/smbclient
