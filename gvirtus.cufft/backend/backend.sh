#!/bin/bash

if [ $# -ne 1 ]; then
  echo usage: $0 "<path-of-installation-folder>"
  exit 1
fi

INSTALL_FOLDER=$1
echo $INSTALL_FOLDER

cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=${INSTALL_FOLDER} -G "CodeBlocks - Unix Makefiles" -j 4 .
make
make install

rm -rf cufft-backend.cbp libcufft-backend.so libcufft-backend.a
