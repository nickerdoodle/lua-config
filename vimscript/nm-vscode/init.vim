" packadd surround
" uncomment if you want to use quick-scope
" packadd quick-scope
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline
" highlight QuickScopeSecondary guifg='#eF5F70' gui=underline ctermfg=81 cterm=underline
" let g:qs_max_chars=150
"
set ignorecase
set smartcase

" TODO there is a more contemporary version of this file
"VSCode
function! s:split(...) abort
    let direction = a:1
    let file = a:2
    call VSCodeCall(direction == 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
    if file != ''
        call VSCodeExtensionNotify('open-file', expand(file), 'all')
    endif
endfunction

function! s:splitNew(...)
    let file = a:2
    call s:split(a:1, file == '' ? '__vscode_new__' : file)
endfunction

function! s:closeOtherEditors()
    call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')
    call VSCodeNotify('workbench.action.closeOtherEditors')
endfunction

function! s:manageEditorSize(...)
    let count = a:1
    let to = a:2
    for i in range(1, count ? count : 1)
        call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
    endfor
endfunction

command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')
command! -bang Only if <q-bang> == '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif

"set my leader key
let mapleader = " "
" nnoremap <silent> <C-w>s :call <SID>split('h')<CR>
" xnoremap <silent> <C-w>s :call <SID>split('h')<CR>

" nnoremap <silent> <C-w>v :call <SID>split('v')<CR>
" xnoremap <silent> <C-w>v :call <SID>split('v')<CR>
" thought these would split terminals but don't know what they do yet
nnoremap <leader>s :call <SID>split('h')<CR>
xnoremap <leader>s :call <SID>split('h')<CR>

nnoremap <leader>v :call <SID>split('v')<CR>
xnoremap <leader>v :call <SID>split('v')<CR>

nnoremap <silent> <C-w>n :call <SID>splitNew('h', '__vscode_new__')<CR>
xnoremap <silent> <C-w>n :call <SID>splitNew('h', '__vscode_new__')<CR>


nnoremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
xnoremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>

nnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
xnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
nnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
xnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
nnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
xnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
nnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
xnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>

" Better Navigation
" Good to still use these mappings if editor is a terminal
nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

" Bind C-/ to vscode commentary since calling from vscode produces double comments due to multiple cursors
" xnoremap <silent> <C-/> :call Comment()<CR>
" nnoremap <silent> <C-/> :call Comment()<CR>

nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

"don't know what this does. Find out
"nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
"xnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>

" mapping to replace escape
imap jj <Esc>

"moves between terminal windows hjkl
"Since leader is space key, press space and the h to move to left terminal
nnoremap <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
"pull up list of all current tabs
nnoremap <leader>e :call VSCodeNotify('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')<CR>

"go to definition
nnoremap gd :call VSCodeNotify('editor.action.revealDefinition')<CR>
nnoremap gr :call VSCodeNotify('references-view.findReferences')<CR>
nnoremap gh :call VSCodeNotify('editor.action.showHover')<CR>
" nnoremap <leader>K :call VSCodeNotify('editor.action.showDefinitionPreviewHover')<CR>
nnoremap H :call VSCodeNotify('editor.action.showDefinitionPreviewHover')<CR>
nnoremap <leader>ca :call VSCodeNotify('editor.action.quickFix')<CR>
"new terminal
nnoremap <leader>tn :call VSCodeNotify('workbench.action.terminal.newInActiveWorkspace')<CR>

"kill terminal
nnoremap <leader>tk :call VSCodeNotify('workbench.action.terminal.kill')<CR>

" commenting mappings with ctrl key
xmap <C-/>  <Plug>VSCodeCommentary
nmap <C-/> <Plug>VSCodeCommentary
omap <C-/> <Plug>VSCodeCommentary
nmap <C-/> :call VSCodeNotify('editor.action.revealDefinition')<CR>
" xmap gc  <Plug>VSCodeCommentary
xmap gc <C-/>
" nmap gc <Plug>VSCodeCommentary
nmap gc <C-/>
" omap gc <Plug>VSCodeCommentary
omap gc <C-/>
" nmap gcc <Plug>VSCodeCommentaryLine
nmap gcc <C-/>

" turbo console log
nnoremap <leader>tc viw<cmd>call VSCodeNotifyVisual('turboConsoleLog.displayLogMessage', 1)<CR><ESC>
xnoremap <leader>tc <cmd>call VSCodeNotifyVisual('turboConsoleLog.displayLogMessage', 1)<CR><ESC>
" I don't know why :call doesn't work and <cmd>call does work for visual
" commands in vscode, but that's how it is
nnoremap ? :call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>
nnoremap <leader><leader>f :call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>
xnoremap <leader><leader>f <cmd>call VSCodeNotifyVisual('workbench.action.findInFiles', 1)<CR>
nnoremap <leader><leader>r viw<cmd>call VSCodeNotifyVisual('workbench.action.replaceInFiles', { 'query': expand('<cword>')})<CR>
xnoremap <leader><leader>r <cmd>call VSCodeNotifyVisual('workbench.action.replaceInFiles', 1)<CR>

xnoremap <leader><leader>c <cmd>call VSCodeNotifyVisual('editor.action.clipboardCopyAction')<CR>

"From my lua files
nnoremap J 5j
nnoremap K 5k
nnoremap L g_
" nnoremap H ^
vnoremap gJ :join<CR>
vnoremap < <gv
vnoremap > >gv
xnoremap K :move <-2<CR>gv-gv
xnoremap J :move <+1<CR>gv-gv

