" General vim tex settings

if exists("b:did_tex_settings")
	finish
endif
let b:did_tex_settings = 1

setlocal textwidth=78
setlocal colorcolumn=+0
setlocal tabstop=3
setlocal shiftwidth=3
setlocal spell
setlocal spelllang=de,en
