if [ "x${X265_VERSION}" == "xhg" ]; then
    hg_clone https://bitbucket.org/multicoreware/x265 x265_${X265_VERSION}
else
    download_file https://bitbucket.org/multicoreware/x265/downloads/x265_${X265_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
if [ "x${X265_VERSION}" == "xhg" ]; then
    pushd $SRC_ROOT/x265_${X265_VERSION}
    hg log -r0 --template "repo: {node}\n" > .hg_archival.txt
    hg log -r. --template "node: {node}\n" >> .hg_archival.txt
    hg log -r. --template "branch: {branch}\n" >> .hg_archival.txt
    hg log -r. --template "latesttag: {latesttag}\n" >> .hg_archival.txt
    hg log -r. --template "latesttagdistance: {latesttagdistance}\n" >> .hg_archival.txt
    popd
fi
mkdir -p $BUILD_ROOT/x265_${X265_VERSION}
pushd $BUILD_ROOT/x265_${X265_VERSION}
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$BUILD_INSTALL_ROOT -DENABLE_CLI=Off -DENABLE_PIC=On -DENABLE_SHARED=Off $SRC_ROOT/x265_${X265_VERSION}/source
make $JOBS
make install
popd
