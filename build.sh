#!/bin/bash

echo "Removing homebrew"
/usr/bin/sudo /usr/bin/find /usr/local/Frameworks /usr/local/bin /usr/local/etc /usr/local/include /usr/local/lib /usr/local/opt /usr/local/sbin /usr/local/share /usr/local/var -name .DS_Store -delete

/usr/bin/sudo /usr/bin/find /usr/local/Frameworks /usr/local/bin /usr/local/etc /usr/local/include /usr/local/lib /usr/local/opt /usr/local/sbin /usr/local/share /usr/local/var -depth -type d -empty -exec rmdir {} ;

echo "BEGIN DEBUG"
echo "XCODES AVAILABLE:"
xcode-select --print-path

#echo "INSTALLING?"
#xcode-select --install
export CC="gcc"
export CXX="g++"

echo "CC IS: $(which cc)"
echo "CLANG IS: $(which clang)"
echo "TRYNA RUN CC:"
cc

python -m pip install --no-deps --ignore-installed .
