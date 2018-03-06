#!/bin/bash

# Basically this does what travis does. Gotta replicate!!!

export CONDA_NPY=19

# Remove homebrew.
echo ""
echo "Removing homebrew from Travis CI to avoid conflicts."
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall > ~/uninstall_homebrew
chmod +x ~/uninstall_homebrew
~/uninstall_homebrew -fq
rm ~/uninstall_homebrew

# Install Miniconda.
echo ""
echo "Installing a fresh version of Miniconda."
curl -L https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh > ~/miniconda.sh
bash ~/miniconda.sh -b -p ~/miniconda
source ~/miniconda/bin/activate root

# Configure conda.
echo ""
echo "Configuring conda."
conda config --add channels conda-forge
conda config --set show_channel_urls true
conda install --yes --quiet conda-build-all
conda install --yes --quiet conda-forge-build-setup
source ~/miniconda/bin/run_conda_forge_build_setup


