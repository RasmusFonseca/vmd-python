#!/bin/bash

echo "BEGIN DEBUG"
echo "XCODES AVAILABLE:"
xcode-select --print-path

#echo "INSTALLING?"
#xcode-select --install

echo "CC IS: $(which cc)"
echo "CLANG IS: $(which clang)"
echo "TRYNA RUN CC:"
cc

python setup.py build
python setup.py install
#python -m pip install --no-deps --ignore-installed .
