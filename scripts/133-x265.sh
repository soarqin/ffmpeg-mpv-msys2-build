hg_clone https://bitbucket.org/multicoreware/x265 x265
if [ $result == true ]; then return; fi
cd $SRC_ROOT/x265
hg log -r0 --template "repo: {node}\n" > .hg_archival.txt
hg log -r. --template "node: {node}\n" >> .hg_archival.txt
hg log -r. --template "branch: {branch}\n" >> .hg_archival.txt
hg log -r. --template "latesttag: {latesttag}\n" >> .hg_archival.txt
hg log -r. --template "latesttagdistance: {latesttagdistance}\n" >> .hg_archival.txt
cd $BUILD_ROOT && mkdir -p x265 && cd x265
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$BUILD_INSTALL_ROOT -DENABLE_CLI=Off -DENABLE_PIC=On -DENABLE_SHARED=Off $SRC_ROOT/x265/source
make $JOBS
make install
