git_clone https://github.com/alexmarsev/libbs2b libbs2b-git
if [ "$result" = true ]; then return; fi
patch_source libbs2b-git 120-libbs2b.patch
compile_with_configure libbs2b-git --enable-static --disable-shared
