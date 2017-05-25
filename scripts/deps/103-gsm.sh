download_file http://libgsm.sourcearchive.com/downloads/1.0.13-4/libgsm_1.0.13.orig.tar.gz gsm-1.0-pl13
if [ $result == true ]; then return; fi
patch_source gsm-1.0-pl13 103-gsm.patch 1
pushd ${BUILD_ROOT}
cp -Rf ${SRC_ROOT}/gsm-1.0-pl13 .
pushd gsm-1.0-pl13
make gsminstall INSTALL_ROOT=$BUILD_INSTALL_ROOT
popd
popd
