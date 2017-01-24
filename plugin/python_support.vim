
if !has('nvim')
	finish
endif

" command PythonSupport
let s:python2_require = get(g:,'python_support_python2_require',1)
let s:python3_require = get(g:,'python_support_python3_require',1)

let s:python3_requirements = get(g:,'python_support_python3_requirements',[])
let s:python2_requirements = get(g:,'python_support_python2_requirements',[])

com! PythonSupportInitPython2 call s:python_support_init(2)
com! PythonSupportInitPython3 call s:python_support_init(3)

func! s:python_support_init(v)
	split
	enew
	call termopen('/bin/sh ' .  split(globpath(&rtp,'autoload/python'.a:v.'_support.sh'),'\n')[0])
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
	elseif s:python2_require
		echom 'python2 not provided by python-support.nvim. Please execute PythonSupportInitPython2'
	endif
	if l:python3 != ''
		let g:python3_host_prog = l:python3
	elseif s:python3_require
		echom 'python3 not provided by python-support.nvim. Please execute PythonSupportInitPython3'
	endif
endfunc

call s:init()

