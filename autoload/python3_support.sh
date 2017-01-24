#!/bin/sh

cd $(dirname "${BASH_SOURCE[0]}")

set -e
set -x

echo 'initializing python3 virtualenv for neovim'

rm -rf nvim_py3
python3 -m venv nvim_py3
. nvim_py3/bin/activate
pip install "$@"
deactivate

echo 'init finished'

