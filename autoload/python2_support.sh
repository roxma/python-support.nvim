#!/bin/bash

set -e
set -x

cd $(dirname "${BASH_SOURCE[0]}")

echo 'initializing python2 virtualenv for neovim'

rm -rf nvim_py2
python2 -m virtualenv nvim_py2
. nvim_py2/bin/activate
pip install "$@"
deactivate

echo 'init finished'

