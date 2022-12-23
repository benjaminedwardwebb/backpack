" options.vim
" Sets vim options.
"
" Documentation can be found by searching for the option name wrapped in
" single quotes. For example,
"
"   :help 'noexpandtab'
"
" See: :help options
" See: :help option-summary
runtime pagerOptions.vim
set loadplugins
set number

set backspace=indent,eol,start
set colorcolumn=""
set foldcolumn=0
set foldlevelstart=99
set foldmethod=indent
set foldtext=g:FoldText()
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set nowrap
autocmd FileType markdown setlocal wrap
set showbreak=↪\ 
set signcolumn=number
set splitbelow
set splitright
set textwidth=78
autocmd FileType markdown setlocal textwidth=0
set whichwrap+=h,l,<,>

" Displays the first line of the fold.
" This must be a global function to work properly.
function g:FoldText()
	" Gets the first line of the fold.
	let line = getline(v:foldstart)

	" When evaluating foldtext, vim replaces tab characters with spaces.
	" To maintain alignment, we proactively expand tabs based on the
	" buffer's value of tabstop. Tabs are expanded only in the foldtext
	" string returned by this function, not on the entire buffer.
	" See: :help fold-foldtext
	let spacesPerTab = &tabstop
	let expandedTab = repeat(' ', spacesPerTab)
	let flags = ""
	let foldtext = line->substitute("\t", expandedTab, flags)

	return foldtext
endfunction
