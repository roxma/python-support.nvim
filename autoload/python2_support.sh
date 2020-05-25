#!/usr/bin/env bash

set -e
set -x

cd $(dirname "${BASH_SOURCE[0]}")

echo 'initializing python2 virtualenv for neovim'

python_exec=$1
shift

venv=$1
shift

if [[ $venv == 1 ]]
then
    rm -rf nvim_py2
    "$python_exec" -m virtualenv nvim_py2
    . nvim_py2/bin/activate
    pip install "$@"
elif [ -n "$VIRTUAL_ENV" -a -f "$VIRTUAL_ENV/bin/python2" ]
then
    "$VIRTUAL_ENV/bin/python2" -m pip install "$@"
else
    "$python_exec" -m pip install --user "$@"
fi

echo 'init finished'

