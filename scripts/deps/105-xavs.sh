svn_checkout https://svn.code.sf.net/p/xavs/code/trunk xavs
if [ "$result" = true ]; then return; fi
compile_with_configure_dirty xavs --disable-pthread --enable-pic
