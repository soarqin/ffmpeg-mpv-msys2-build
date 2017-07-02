if [ "x${MPG123_VERSION}" == "xsvn" ]; then
    svn_checkout svn://scm.orgis.org/mpg123/trunk mpg123-${MPG123_VERSION}
else
    download_file https://sourceforge.net/projects/mpg123/files/mpg123/${MPG123_VERSION}/mpg123-${MPG123_VERSION}.tar.bz2/download
fi
if [ "$result" = true ]; then return; fi
patch_source mpg123-${MPG123_VERSION} 115-mpg123.patch
compile_with_configure mpg123-${MPG123_VERSION} --enable-static --disable-shared --enable-modules=no
