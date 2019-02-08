" Merged from many sources to be my own, personal script
" sirjofri 2019

" {{{ Do only once!
if exists("b:did_tex_autocompile")
	finish
endif
let b:did_tex_autocompile = 1
" }}}

" {{{ Set Make Program
if filereadable("Makefile")
	set makeprg=make\ 2>/dev/null\ &>/dev/null
else
	set makeprg=pdflatex\ -interaction=nonstopmode\ -halt-on-error\ -file-line-error\ -synctex=1\ %\ 2>/dev/null\ &>/dev/null
endif
" }}}

let s:job_free = 1

function! ResetLatexCompilationStatus(job, status)
	let s:job_free = 1
endfunction

" {{{ Compile function
function! <SID>Compile()
	if has("job")
		if s:job_free
			silent! update
			call job_start(["/bin/sh","-c","make 2>/dev/null &>/dev/null </dev/null"], {"exit_cb":"ResetLatexCompilationStatus"})
			let s:job_free = 0
		endif
	else
		silent! update
		silent exec "silent! make"
		redraw!
	endif
endfunction
" }}}

" Compile on Save/Exit
au! BufWritePost,VimLeave <buffer> silent call <SID>Compile()

" {{{ Setup Compile Draft functionality
if has("job")
	let s:draft_job_free = 1
	let g:live_preview = 0 " default: off

	function! ResetLatexDraftCompilationStatus(job, status)
		let s:draft_job_free = 1
		echo "Draft"
	endfunction

	function! <SID>CompileDraft()
		if s:draft_job_free
			if filereadable("Makefile")
				silent! update
				call job_start(["/bin/sh","-c","make draft 2>/dev/null &>/dev/null </dev/null"], {"exit_cb":"ResetLatexDraftCompilationStatus"})
				let s:draft_job_free = 0
			endif
		endif
	endfunction

	au! TextChanged,TextChangedI,InsertLeave <buffer> if g:live_preview | silent call <SID>CompileDraft() | endif

	function! <SID>ToggleLivePreview()
		if g:live_preview
			let g:live_preview = 0
		else
			let g:live_preview = 1
		endif
	endfunction

	command! ToggleLLP :call <SID>ToggleLivePreview()
endif
" }}}

" vim:fdm=marker:noet
