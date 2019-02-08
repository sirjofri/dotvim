" general settings for cpp files
"
" Copyright 2018 sirjofri

if exists("b:did_cpp_settings")
	finish
endif
let b:did_cpp_settings = 1

setlocal foldmethod=syntax
setlocal textwidth=78
setlocal colorcolumn=+0
setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab

inoremap { {<CR>}<ESC>O
