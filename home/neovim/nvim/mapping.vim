" mapping.vim
" Maps keys to vim commands.
" See: :help mapping

" Map keys to scrolling commands.
" Mapping to C-e must be done before it is remapped below.
" See: :help CTRL-E
nnoremap <M-k> <C-y>
nnoremap <M-j> <C-e>

" Map keys to tab page commands.
nnoremap <C-e> :tabnew
nnoremap <C-w> :tabclose<Enter>
nnoremap <S-J> :tabnext<Enter>
nnoremap <S-K> :tabprevious<Enter>

" Map keys to window commands.
" nnoremap TODO :new<Enter>
nnoremap <C-q> :close<Enter>
" nnoremap <C-n> :vsplit<Enter>
" nnoremap <C-b> :split<Enter>
nnoremap <C-j> :wincmd j<Enter>
nnoremap <C-k> :wincmd k<Enter>
nnoremap <C-l> :wincmd l<Enter>
nnoremap <C-h> :wincmd h<Enter>

" Map keys to language server protocol (lsp) commands.
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh          <cmd>lua vim.lsp.buf.hover()<CR>
