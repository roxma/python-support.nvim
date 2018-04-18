
if !has('nvim')
	finish
endif

" command PythonSupport
let s:python2_require = get(g:,'python_support_python2_require',1)
let s:python3_require = get(g:,'python_support_python3_require',1)

let g:python_support_python2_venv = get(g:,'python_support_python2_venv', 1)
let g:python_support_python3_venv = get(g:,'python_support_python3_venv', 1)

let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'neovim')
let g:python_support_python2_requirements = add(get(g:,'python_support_python2_requirements',[]),'neovim')
" let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'flake8')
" let g:python_support_python2_requirements = add(get(g:,'python_support_python2_requirements',[]),'flake8')

com! PythonSupportInitPython2 call s:python_support_init(2)
com! PythonSupportInitPython3 call s:python_support_init(3)

func! s:python_support_init(v)
	split
	enew
	if a:v==2
		let l:cmd = [split(globpath(&rtp,'autoload/python2_support.sh'),'\n')[0]] + [g:python_support_python2_venv] + g:python_support_python2_requirements
	else
		let l:cmd = [split(globpath(&rtp,'autoload/python3_support.sh'),'\n')[0]] + [g:python_support_python3_venv] + g:python_support_python3_requirements
	endif
    exec '! ' . join(l:cmd, ' ')
    call s:init()
endfunc

func! s:init()

	let l:python2 = ""
	let l:python3 = ""

    if s:python2_require
        if g:python_support_python2_venv
            silent! let l:python2 = split(globpath(&rtp,'autoload/nvim_py2/bin/python'),'\n')[0]
            if l:python2 != ''
                let g:python_host_prog = l:python2
            else
                echom 'python2 venv not initialized by python-support.nvim. Please execute PythonSupportInitPython2'
            endif
        elseif executable('python2') && get(g:,'python_host_prog','') == ''
            let g:python_host_prog = "python2"
        elseif get(g:, 'python_host_prog', '') == ''
            echom 'python2 executable not found for python_support.vim'
        endif

        if get(g:, 'python_host_prog', '') != ''
            " spawn python process to check requirements 1 second later
            call timer_start(1000,function('s:py2requirements'))
        endif
    endif

    if s:python3_require
        if g:python_support_python3_venv
            silent! let l:python3 = split(globpath(&rtp,'autoload/nvim_py3/bin/python'),'\n')[0]
            if l:python3 != ''
                let g:python3_host_prog = l:python3
            else
                echom 'python3 venv not initialized by python-support.nvim. Please execute PythonSupportInitPython3'
            endif
        elseif executable('python3') && get(g:, 'python3_host_prog', '') == ''
            let g:python3_host_prog = 'python3'
        elseif get(g:, 'python3_host_prog', '') == ''
            echom 'python3 executable not found for python_support.vim'
        endif

        if get(g:, 'python3_host_prog', '') != ''
            " spawn python process to check requirements 1 second later
            call timer_start(1000,function('s:py3requirements'))
        endif
    endif

endfunc

func! s:py2requirements(timer)
	if empty(g:python_support_python2_requirements)
		" no requirements
		return
	endif
    let l:python = g:python_host_prog
    if l:python == ''
        let l:python = 'python2'
    endif
	let l:cmd = [l:python, split(globpath(&rtp,'autoload/python2_check.py'),'\n')[0]] + g:python_support_python2_requirements
	call jobstart(l:cmd,{'on_stdout':function('s:on_stdout'), 'on_stderr':function('s:on_stdout')})
endfunc

func! s:py3requirements(timer)
	if empty(g:python_support_python3_requirements)
		" no requirements
		return
	endif
    let l:python = g:python3_host_prog
    if l:python == ''
        let l:python = 'python3'
    endif
	let l:cmd = [l:python, split(globpath(&rtp,'autoload/python3_check.py'),'\n')[0]] + g:python_support_python3_requirements
	call jobstart(l:cmd,{'on_stdout':function('s:on_stdout'), 'on_stderr':function('s:on_stdout')})
endfunc

func! s:on_stdout(job_id, data, event)
	echom join(a:data,"\n")
endfunc

call s:init()

