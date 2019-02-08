" This is my (new) .vimrc
" Have fun reading this and learning from it, or even using it!

" {{{ Basic Settings
filetype off
syntax on
filetype plugin indent on
colorscheme koehler
set si
set hls
set relativenumber
set number
set so=3
" }}}

" {{{ Encoding, Tab arrow, trailing spaces
set encoding=utf-8
set listchars=tab:→\ ,trail:·
set list
" }}}

" {{{ adds justification functionality
" :help usr_25 - adds _j justify function
:packadd! justify
" }}}

" {{{ Restore cursor to file position in previous editing session (stolen)
" see http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
set viminfo='100,<50,s10,h,\"100,:20,%
function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction
if has("folding")
	function! UnfoldCur()
		if !&foldenable
			return
		endif
		let cl = line(".")
		if cl <= 1
			return
		endif
		let cf = foldlevel(cl)
		let uf = foldlevel(cl - 1)
		let min = (cf > uf ? uf : cf)
		if min
			execute "normal!" min."zo"
			return 1
		endif
	endfunction
endif
augroup resCur
	autocmd!
	if has("folding")
		autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
	else
		autocmd BufWinEnter * call ResCur()
	endif
augroup END
" }}}

" {{{ Color Settings
hi VertSplit ctermbg=green ctermfg=0
hi StatusLine ctermbg=4 ctermfg=green
hi StatusLineNC ctermbg=green ctermfg=4 cterm=NONE
" }}}

" {{{ Highlight Tags (:Thl)
function! HighlightTags()
	if filereadable("tags")
		let file = readfile("tags")
		for line in file
			let match = substitute(line, "\t.*$", "", "")
			execute "syntax keyword Tag ".match
		endfor
	endif
endfunction

command! Thl :call HighlightTags()
" }}}

" {{{ Synctex – I do not really use this
function! Synctex()
	" remove silent for debugging
	execute "silent !zathura --synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . " " . g:syncpdf
endfunction
map <C-enter> :call Synctex()<cr>
" }}}

" {{{ Auto filetype settings
augroup filetypedetect
	au! BufNewFile,BufRead *.inc setf php | set tabstop=2
	au! BufNewFile,BufRead * if &ft == 'php'||&ft == 'html' | set tabstop=2 | set sw=2 | endif
	au! BufNewFile,BufRead * if &ft == 'css' | set tabstop=3 | set sw=3 | endif
augroup END
" }}}

" {{{ Questionable Content
" Does this do anything?
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
" }}}

" {{{ Auto execute local vim settings (for auth data etc, not shared with others)
if filereadable(expand("~/.vim/locals.vim"))
	source ~/.vim/locals.vim
endif
" }}}

" {{{ Auto execute directory relevant settings (for project specific vim settings)
if filereadable(".settings.vim")
	source .settings.vim
endif
" }}}

" vim:ts=3:sw=3:noet:fdm=marker
