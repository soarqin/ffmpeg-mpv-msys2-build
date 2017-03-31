git_clone https://git.code.sf.net/p/modplug-xmms/git modplug
cd $SRC_ROOT/modplug/libmodplug
sed -i -e 's,Libs.private:,Libs.private: -DMODPLUG_STATIC,g' libmodplug.pc.in
compile_with_configure modplug/libmodplug --enable-static --disable-shared
