if [ "x${GRAPHITE2_VERSION}" == "xgit" ]; then
    git_clone https://github.com/silnrsi/graphite graphite2-${GRAPHITE2_VERSION}
else
    download_file https://github.com/silnrsi/graphite/archive/graphite2-${GRAPHITE2_VERSION}.tar.gz
fi
if [ "$result" = true ]; then return; fi
patch_source graphite2-${GRAPHITE2_VERSION} 024-graphite2.patch
compile_with_cmake graphite2-${GRAPHITE2_VERSION}
