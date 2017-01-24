
if !has('nvim')
	finish
endif

" command PythonSupport

com! PythonSupportInit call s:python_support_init()

func! s:python_support_init()
	split
	enew
	call termopen('/bin/sh ' .  globpath(&rtp,'autoload/python_support.sh'))
	startinsert
	autocmd termclose  <buffer>  call s:init()
endfunc

func! s:init()
	
	let l:python2 = globpath(&rtp,'autoload/nvim_py2/bin/python')
	let l:python3 = globpath(&rtp,'autoload/nvim_py3/bin/python')
	if l:python2 != ''
		let g:python_host_prog = l:python2
	else
		echom 'python2 not provided by python-support.nvim. Please execute PythonSupportInit'
	endif
	if l:python3 != ''
		let g:python3_host_prog = l:python3
	else
		echom 'python3 not provided by python-support.nvim. Please execute PythonSupportInit'
	endif
endfunc

call s:init()

