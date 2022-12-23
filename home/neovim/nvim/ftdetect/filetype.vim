" filetype.vim
" Detects filetypes.
"
" Vim's manual suggests creating separate files for each filetype. But these
" are all in one file to avoid conflicts and ease viewing them all together.
"
" This is sourced by both vim and vimpager. Be sensitive to performance.
"
" See: :help ftdetect

" Note the * before vimpagerrc. Vimpager opens it as a tmp file like:
" /tmp/vimpager_16955/_Users_benjamin-webb_.vim_vimpagerrc
autocmd BufNewFile,BufRead *vimpagerrc setlocal filetype=vim

autocmd BufNewFile,BufRead *.hql setlocal filetype=hive
autocmd BufNewFile,BufRead *.q setlocal filetype=hive

autocmd BufNewFile,BufRead Jenkinsfile setlocal filetype=groovy

function DetectKubernetesObjectYamlByContent()
	if getline(1) =~ '^apiVersion:'
		set filetype=yaml
	endif
endfunction
autocmd BufNewFile,BufRead * call DetectKubernetesObjectYamlByContent()

" Special filetype detection rules are used for the GhostText framework, which
" opens .txt files that we want to treat as markdown.
autocmd BufNewFile,BufRead *ghost-github.com* setlocal filetype=markdown
