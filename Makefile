.PHONY: install
install: ~/.vimrc download
	git submodule update --init

~/.vimrc: ~/.vim/vimrc
	ln -s ~/.vim/vimrc ~/.vimrc

.PHONY: upgrade
upgrade:
	git submodule update --remote --merge

.PHONY: download
download: syntax/de.vim syntax/en.vim syntax/po.vim syntax/noweb.vim

syntax/de.vim:
	curl -L https://raw.githubusercontent.com/blueponies666/natural-language-vim/master/de.vim > $@

syntax/en.vim:
	curl -L https://raw.githubusercontent.com/blueponies666/natural-language-vim/master/en.vim > $@

syntax/po.vim:
	curl -L https://www.vim.org/scripts/download_script.php?src_id=8528 > $@

syntax/noweb.vim:
	curl -L https://www.vim.org/scripts/download_script.php?src_id=13268 > $@
