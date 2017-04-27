if [ "x${MPG123_VERSION}" == "xsvn" ]; then
    svn_checkout svn://scm.orgis.org/mpg123/trunk mpg123-${MPG123_VERSION}
else
    download_file https://sourceforge.net/projects/mpg123/files/mpg123/${MPG123_VERSION}/mpg123-${MPG123_VERSION}.tar.bz2/download
fi
if [ $result == true ]; then return; fi
pushd ${SRC_ROOT}/mpg123-${MPG123_VERSION}
if [ "x$(grep Libs.private libmpg123.pc.in)" == "x" ]; then
    sed -i -s 's,Libs: -L${libdir} -lmpg123,Libs: -L${libdir} -lmpg123\nLibs.private: -lshlwapi ,g' libmpg123.pc.in
fi
popd

if [ $result == true ]; then return; fi
compile_with_configure mpg123-${MPG123_VERSION} --enable-static --disable-shared --enable-modules=no
