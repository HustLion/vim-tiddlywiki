" Vim filetype plugin for TiddlyWiki
" Language: tiddlywiki
" Maintainer: Devin Weaver <suki@tritarget.org>
" License: http://www.apache.org/licenses/LICENSE-2.0.txt

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo-=C

" :set includeexpr=v:fname.'.tid'
" setup tid file
autocmd BufNewFile,BufRead *.tid set includeexpr=v:fname.'.tid'

function! TiddlyWikiTime()
  return system("date -u +'%Y%m%d%H%M%S'")[:-2] . "000"
endfunction

function! s:UpdateModifiedTime()
  let save_cursor = getcurpos()
  silent 0,/^\s*$/global/^modified: / delete
  call append(0, "modified: " . TiddlyWikiTime())
  call setpos('.', save_cursor)
endfunction

function! s:AutoUpdateModifiedTime()
  if &modified
    call <SID>UpdateModifiedTime()
  endif
endfunction

function! s:InitializeTemplate()
  let timestamp = TiddlyWikiTime()
  call append(0, "modified: " . timestamp)
  call append(1, "created: " . timestamp)
  call append(2, "modifier: ")
  call append(3, "creator: ")
  call append(4, "title: ")
  call append(5, "tags: ")
  call append(6, "")
endfunction

if exists("g:tiddlywiki_autoupdate")
  augroup tiddlywiki
    au BufWrite, *.tid call <SID>AutoUpdateModifiedTime()
  augroup END
endif

" 获得 [[]] 里面的内容，然后用 ctrlp
" 打开这个文件，或者说，就打开当前目录下这个文件
function! <SID>JumpToTiddler()
 let wordUnderCursor = expand("<cword>")
 let currentLine   = getline(".") 
endfunction

if !exists("g:tiddlywiki_no_mappings")
  nmap <Leader>tm :call <SID>UpdateModifiedTime()<Cr>
  nmap <Leader>tt :call <SID>InitializeTemplate()<Cr>
  " go right after the [ and select to the closest ] and jump
  " and open in new tab
  nmap <buffer> gf T[vt]<C-W>gf
endif

let &cpo = s:save_cpo
