" syntax.vim
" Highlights syntax in vim.
" See: :help syntax
runtime pagerSyntax.vim

" Highlight groups related to line numbering and sign columns.
highlight LineNr ctermfg=10 ctermbg=0

" We `set signcolumn=number` in formatting.vim, meaning the
" LineNr column is reused as the SignColumn to display vim
" signs. Therefore, we explicitly highlight the SignColumn
" with `none` to remove any specific coloring for that group.
" See: :help SignColumn
" See: :help signs
" See: :help cterm-colors
highlight SignColumn ctermfg=none ctermbg=none

" Highlights vim-gitgutter groups. These groups apply over the
" SignColumn for edited lines.
highlight GitGutterAdd ctermfg=2 ctermbg=0
highlight GitGutterChange ctermfg=3 ctermbg=0
highlight GitGutterDelete ctermfg=1 ctermbg=0

" Highlights the foldtext displayed over folded folds.
" See: folding.vim
highlight FoldColumn ctermfg=13
highlight Folded ctermfg=13 ctermbg=none cterm=none

" Highlights tabline groups. These are tab page tabs, not indentation tabs.
" See: :h tabline
" These groups have cterm set to underline by default. We set it to
" none to remove the tabline's underline.
" See: :h underline
highlight TabLineFill cterm=none ctermfg=8 ctermbg=0
highlight TabLine cterm=none ctermfg=10 ctermbg=0

" This group has cterm set to underline and reverse (or inverse) by
" default. We set it to none to remove the underline and the
" foreground-background color inversion on the selected tab.
" See: :h inverse
highlight TabLineSel cterm=none ctermfg=3 ctermbg=8

" Override the end of buffer highlighting used when paging.
highlight EndOfBuffer ctermfg=0 ctermbg=0
