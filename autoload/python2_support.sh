#!/bin/sh

cd $(dirname "${BASH_SOURCE[0]}")

set -e
set -x

echo 'initializing python2 virtualenv for neovim'

rm -rf nvim_py2
python2 -m virtualenv nvim_py2
. nvim_py2/bin/activate
pip install neovim
pip install flake8
deactivate

echo 'init finished'

