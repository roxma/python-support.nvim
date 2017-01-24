
if !has('nvim')
	finish
endif

" command PythonSupport

" let s:python3_requirements = get(g:,'python_support_python3_requirements','')
" let s:python2_requirements = get(g:,'python_support_python2_requirements','')

com! PythonSupportInit call s:python_support_init()

func! s:python_support_init()
	split
	enew
	call termopen('/bin/sh ' .  split(globpath(&rtp,'autoload/python_support.sh'),'\n')[0])
	startinsert
	autocmd termclose  <buffer>  call s:init()
endfunc

func! s:init()
	
	let l:python2 = ""
	let l:python3 = ""
	try
		let l:python2 = split(globpath(&rtp,'autoload/nvim_py2/bin/python'),'\n')[0]
		let l:python3 = split(globpath(&rtp,'autoload/nvim_py3/bin/python'),'\n')[0]
	catch
	endtry
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

