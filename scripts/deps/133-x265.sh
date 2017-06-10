if [ "x${X265_VERSION}" == "xhg" ]; then
    hg_clone https://bitbucket.org/multicoreware/x265 x265_${X265_VERSION}
    if [ $result == true ]; then return; fi
    pushd $SRC_ROOT/x265_${X265_VERSION}
    hg log -r0 --template "repo: {node}\n" > .hg_archival.txt
    hg log -r. --template "node: {node}\n" >> .hg_archival.txt
    hg log -r. --template "branch: {branch}\n" >> .hg_archival.txt
    hg log -r. --template "latesttag: {latesttag}\n" >> .hg_archival.txt
    hg log -r. --template "latesttagdistance: {latesttagdistance}\n" >> .hg_archival.txt
    popd
else
    download_file https://bitbucket.org/multicoreware/x265/downloads/x265_${X265_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi

rm -rf $BUILD_ROOT/x265_${X265_VERSION}
mkdir -p $BUILD_ROOT/x265_${X265_VERSION}
pushd $BUILD_ROOT/x265_${X265_VERSION}

if [ "x${ARCH}" == "x32" ]; then
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$BUILD_INSTALL_ROOT -DENABLE_CLI=OFF -DENABLE_PIC=ON -DENABLE_SHARED=OFF $SRC_ROOT/x265_${X265_VERSION}/source
    make ${MAKE_JOBS}
else
    mkdir -p 8bit 10bit 12bit
    cd 12bit
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DHIGH_BIT_DEPTH=ON -DEXPORT_C_API=OFF -DENABLE_SHARED=OFF -DENABLE_CLI=OFF -DENABLE_PIC=ON -DMAIN12=ON $SRC_ROOT/x265_${X265_VERSION}/source
    make ${MAKE_JOBS}
    cp libx265.a ../8bit/libx265_main12.a

    cd ../10bit
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DHIGH_BIT_DEPTH=ON -DEXPORT_C_API=OFF -DENABLE_SHARED=OFF -DENABLE_CLI=OFF -DENABLE_PIC=ON $SRC_ROOT/x265_${X265_VERSION}/source
    make ${MAKE_JOBS}
    cp libx265.a ../8bit/libx265_main10.a

    cd ../8bit
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$BUILD_INSTALL_ROOT -DEXTRA_LIB="x265_main10.a;x265_main12.a" -DEXTRA_LINK_FLAGS=-L. -DLINKED_10BIT=ON -DLINKED_12BIT=ON -DENABLE_CLI=OFF -DENABLE_PIC=ON -DENABLE_SHARED=OFF $SRC_ROOT/x265_${X265_VERSION}/source
    make ${MAKE_JOBS}

    # rename the 8bit library, then combine all three into libx265.a using GNU ar
    mv libx265.a libx265_main.a

    ar -M <<EOF
    CREATE libx265.a
    ADDLIB libx265_main.a
    ADDLIB libx265_main10.a
    ADDLIB libx265_main12.a
    SAVE
    END
EOF
fi

make install

popd
