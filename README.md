
# python-support.nvim

Use `:PythonSupportInitPython2` and `:PythonSupportInitPython3` to initialize
Python support for Neovim.

If you like setup Python for Neovim manually, you may refer to [this
wiki](https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim)

## Requirements

- For python2 support, you need python2 in your `$PATH`, with virtualenv installed
- For python3 support, you need python3 in your `$PATH`
- If Neovim is started in an active virtualenv, the Python version (and its requirements list, see below) are resolved dynamically, and the requirements installed.

## Usage

Execute `:PythonSupportInitPython2` and `:PythonSupportInitPython3` after you
have installed this plugin.

This plugin automatically checks if a python2 and/or python3 env is set up for Neovim.
It uses a custom path for this under your Neovim configuration directory. If you
don't need python2 or python3, use this to disable checking:

```vim
let g:python_support_python2_require = 0
let g:python_support_python3_require = 0
```

If you have extra need for Python modules, let's say you need flake8
installed, put this into your vimrc file. This plugin will check the
requirements automatically. If requirements are not satisfied, a warning
message will be fired by this plugin. It should be fixed after you execute
`PythonSupportInitPython2` or `PythonSupportInitPython3`.

```vim
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'flake8')
let g:python_support_python2_requirements = add(get(g:,'python_support_python2_requirements',[]),'flake8')
```

Alternatively

```vim
let s:py_reqs = ['jedi', 'flake8', 'isort', 'flake8-isort']
let g:python_support_python3_requirements = extend(get(g:, 'python_support_python3_requirements', []), s:py_reqs)
```

## Notice

I'm working on linux. I haven't test it on other systems. Feel free to send a
PR for other systems support.

