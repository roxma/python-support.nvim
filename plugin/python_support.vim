
if !has('nvim')
	finish
endif

" command PythonSupport
let s:python2_require = get(g:,'python_support_python2_require',1)
let s:python3_require = get(g:,'python_support_python3_require',1)

let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'neovim')
let g:python_support_python2_requirements = add(get(g:,'python_support_python2_requirements',[]),'neovim')
" let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'flake8')
" let g:python_support_python2_requirements = add(get(g:,'python_support_python2_requirements',[]),'flake8')

func! s:python_support_init(v)
	split
	enew
	if a:v==2
		call termopen(['/bin/sh', split(globpath(&rtp,'autoload/python2_support.sh'),'\n')[0]] + g:python_support_python2_requirements)
	else
		call termopen(['/bin/sh', split(globpath(&rtp,'autoload/python3_support.sh'),'\n')[0]] + g:python_support_python3_requirements)
	endif
	startinsert
	autocmd termclose  <buffer>  call s:init()
endfunc

func! s:init()
	com! PythonSupportInitPython2 call s:python_support_init(2)
	com! PythonSupportInitPython3 call s:python_support_init(3)

	let l:python2 = ""
	let l:python3 = ""

	silent! let l:python2 = split(globpath(&rtp,'autoload/nvim_py2/bin/python'),'\n')[0]
	silent! let l:python3 = split(globpath(&rtp,'autoload/nvim_py3/bin/python'),'\n')[0]

	if l:python2 != ''
		let g:python_host_prog = l:python2
		" spawn python process to check requirements 1 second later
		call timer_start(1000,function('s:py2requirements'))
	elseif s:python2_require
		echom 'python2 not provided by python-support.nvim. Please execute PythonSupportInitPython2'
	endif

	if l:python3 != ''
		let g:python3_host_prog = l:python3
		" spawn python process to check requirements 1 second later
		call timer_start(1000,function('s:py3requirements'))
	elseif s:python3_require
		echom 'python3 not provided by python-support.nvim. Please execute PythonSupportInitPython3'
	endif

endfunc

func! s:py2requirements()
	if empty(g:python_support_python2_requirements)
		" no requirements
		return
	endif
	let l:cmd = [g:python_host_prog, split(globpath(&rtp,'autoload/python2_check.py'),'\n')[0]] + g:python_support_python2_requirements
	call jobstart(l:cmd,{'on_stdout':function('s:on_stdout'), 'on_stderr':function('s:on_stdout')})
endfunc

func! s:py3requirements()
	if empty(g:python_support_python3_requirements)
		" no requirements
		return
	endif
	let l:cmd = [g:python3_host_prog, split(globpath(&rtp,'autoload/python3_check.py'),'\n')[0]] + g:python_support_python3_requirements
	call jobstart(l:cmd,{'on_stdout':function('s:on_stdout'), 'on_stderr':function('s:on_stdout')})
endfunc

func! s:on_stdout(job_id, data, event)
	echom join(a:data,"\n")
endfunc

call s:init()

