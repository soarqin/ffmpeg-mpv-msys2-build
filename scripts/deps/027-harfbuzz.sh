if [ "x${HARFBUZZ_VERSION}" == "xgit" ]; then
    git_clone https://anongit.freedesktop.org/git/harfbuzz harfbuzz-${HARFBUZZ_VERSION}
else
    download_file https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-${HARFBUZZ_VERSION}.tar.bz2
fi
if [ "$result" = true ]; then return; fi
compile_with_configure harfbuzz-${HARFBUZZ_VERSION} --enable-static --disable-shared --disable-gtk-doc --disable-gtk-doc-html --enable-introspection --with-glib=no --with-gobject=no --with-cairo=no --with-graphite2=yes --with-icu=no --with-ucdn=yes
