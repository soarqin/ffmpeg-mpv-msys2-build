if [ "x${FDK_AAC_VERSION}" == "xgit" ]; then
    git_clone https://github.com/mstorsjo/fdk-aac fdk-aac-${FDK_AAC_VERSION}
else
    download_file https://github.com/mstorsjo/fdk-aac/archive/v${FDK_AAC_VERSION}.tar.gz fdk-aac-${FDK_AAC_VERSION}
fi
if [ "$result" = true ]; then return; fi
compile_with_configure fdk-aac-${FDK_AAC_VERSION} --enable-shared --disable-static
pushd ${BUILD_INSTALL_ROOT}/lib
gendef ../bin/libfdk-aac-1.dll
dlltool --def libfdk-aac-1.def --output-delaylib libfdk-aac.a
rm -f libfdk-aac-1.def
popd
