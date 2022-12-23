" pagerOptions.vim
" Sets vim options used for paging.
" See: :help options
set noloadplugins
set nonumber

set background=dark
set fillchars=fold:\ ,vert:\│,eob:\ 
set laststatus=0
set noexpandtab
set shiftwidth=4
set tabstop=4

" Set clipboard optons if vim was built with the +xterm_clipboard feature.
" See: :help clipboard
if has("clipboard")
	set clipboard=unnamed
	" Update clipboard option if vim was built with the +X11 feature.
	if has("unnamedplus")
		set clipboard+=unnamedplus
	endif
endif
