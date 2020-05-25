#!/usr/bin/env bash

set -e
set -x

cd $(dirname "${BASH_SOURCE[0]}")

echo 'initializing python3 virtualenv for neovim'

python_exec=$1
shift

venv=$1
shift

if [[ $venv == 1 ]]
then
    rm -rf nvim_py3
    "$python_exec" -m venv nvim_py3
    . nvim_py3/bin/activate
    pip install -U pip
    pip install wheel
    pip install "$@"
elif [ -n "$VIRTUAL_ENV" -a -f "$VIRTUAL_ENV/bin/python3" ]
then
    "$VIRTUAL_ENV/bin/pip" install -U pip
    "$VIRTUAL_ENV/bin/pip" install wheel
    "$VIRTUAL_ENV/bin/pip" install "$@"
else
    "$python_exec" -m pip install --user -U pip
    "$python_exec" -m pip install --user wheel
    "$python_exec" -m pip install --user "$@"
fi

echo 'init finished'
