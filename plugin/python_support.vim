
if !has('nvim')
	finish
endif

" command PythonSupport

com! PythonSupportInit call s:python_support_init()

let s:dir = expand('<sfile>:p:h')

func! s:python_support_init()
	split
	enew
	call termopen('/bin/sh ' . s:dir . '/' . 'python_support.sh')
	startinsert
	autocmd termclose  <buffer>  call s:init()
endfunc

func! s:init()
	let l:python2 = glob(s:dir . '/nvim_py2/bin/python')
	let l:python3 = glob(s:dir . '/nvim_py3/bin/python')
	if l:python2 != ''
		let g:python_host_prog = l:python2
	endif
	if l:python3 != ''
		let g:python3_host_prog = l:python3
	endif
endfunc

call s:init()

