#!/usr/bin/env bash

set -e
set -x

cd $(dirname "${BASH_SOURCE[0]}")

echo 'initializing python3 virtualenv for neovim'

venv=$1

shift

if [[ $venv == 1 ]]
then
    rm -rf nvim_py3
    python3 -m venv nvim_py3
    . nvim_py3/bin/activate
    pip install -U pip
    pip install wheel
    pip install "$@"
elif [ -n "$VIRTUAL_ENV" -a -f "$VIRTUAL_ENV/bin/python3" ]
then
    python3 -m pip install -U pip
    python3 -m pip install wheel
    python3 -m pip install "$@"
else
    python3 -m pip install --user -U pip
    python3 -m pip install --user wheel
    python3 -m pip install --user "$@"
fi

echo 'init finished'
