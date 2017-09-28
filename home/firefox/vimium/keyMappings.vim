unmap <c-y>

unmap gT
map K previousTab

unmap gt
map J nextTab

unmap t
unmap <c-e>
# TODO this doesn't seem to work because <C-e> is mapped and mapping recognition is eager :(
map <C-e><enter> createTab

unmap x
map <C-w> removeTab

unmap o
map : Vomnibar.activate

unmap O
map <C-e> Vomnibar.activateInNewTab

unmap b
map b: Vomnibar.activateBookmarks

unmap T
map t: Vomnibar.activateTabSelection

unmap ge
map <C-l> Vomnibar.activateEditUrl

unmap r
map <C-r> reload
