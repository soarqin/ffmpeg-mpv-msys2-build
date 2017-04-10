download_file http://libgsm.sourcearchive.com/downloads/1.0.13-4/libgsm_1.0.13.orig.tar.gz gsm-1.0-pl13
if [ $result == true ]; then return; fi
cd $BUILD_ROOT
cp -Rf $SRC_ROOT/gsm-1.0-pl13 .
cd gsm-1.0-pl13
sed -i -e '/^INSTALL_ROOT/d' -e 's/444/666/g' -e 's/cp /cp -f /g' -e 's,(GSM_INSTALL_ROOT)/inc$,(GSM_INSTALL_ROOT)/include,g' Makefile
make gsminstall INSTALL_ROOT=$BUILD_INSTALL_ROOT
