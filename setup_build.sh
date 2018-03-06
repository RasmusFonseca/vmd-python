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

echo "Running build setup thing"
# Contents of run_conda_forge_build_setup follow

# 2 cores available on CircleCI workers: https://discuss.circleci.com/t/what-runs-on-the-node-container-by-default/1443
# CPU_COUNT is passed through conda build: https://github.com/conda/conda-build/pull/1149
export CPU_COUNT=2

export PYTHONUNBUFFERED=1

conda config --set show_channel_urls true
conda config --set auto_update_conda false
conda config --set add_pip_as_python_dependency false

conda update -n root --yes --quiet conda conda-env conda-build
conda install -n root --yes --quiet jinja2 anaconda-client
conda install -n root --yes --quiet conda-build=2

conda info
conda config --get

echo "BUILDING!"
conda build-all ./recipes --matrix-condition "numpy >=1.11" "python >=2.7,<3|>=3.5" "r-base ==3.3.2|==3.4.1"
