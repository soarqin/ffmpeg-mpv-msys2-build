if [ "x${VIDSTAB_VERSION}" == "xgit" ]; then
    git_clone https://github.com/georgmartius/vid.stab vid.stab-${VIDSTAB_VERSION}
else
    download_file https://github.com/georgmartius/vid.stab/archive/${VIDSTAB_VERSION}.tar.gz vid.stab-${VIDSTAB_VERSION}
    pushd ${SRC_ROOT}/vid.stab-${VIDSTAB_VERSION}
    sed -i -e 's,vidstab SHARED ,vidstab STATIC ,g' CMakeLists.txt
    popd
fi
if [ $result == true ]; then return; fi
compile_with_cmake vid.stab-${VIDSTAB_VERSION} -DUSE_OMP=OFF -DBUILD_SHARED_LIBS=OFF
