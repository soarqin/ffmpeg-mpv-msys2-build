download_file http://download.savannah.gnu.org/releases/freetype/freetype-${FREETYPE_VERSION}.tar.bz2
if [ "$result" = true ]; then return; fi
patch_source freetype-${FREETYPE_VERSION} 023-freetype.patch
compile_with_configure freetype-${FREETYPE_VERSION} --enable-static --disable-shared --with-harfbuzz=no
