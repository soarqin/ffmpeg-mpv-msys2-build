if [ "x${OPENCORE_AMR_VERSION}" == "xgit" ]; then
    git_clone https://git.code.sf.net/p/opencore-amr/code opencore-amr-${OPENCORE_AMR_VERSION}
else
    download_file https://sourceforge.net/projects/opencore-amr/files/opencore-amr/opencore-amr-${OPENCORE_AMR_VERSION}.tar.gz/download opencore-amr-${OPENCORE_AMR_VERSION}
fi
if [ $result == true ]; then return; fi
compile_with_configure opencore-amr-${OPENCORE_AMR_VERSION} --enable-static --disable-shared
