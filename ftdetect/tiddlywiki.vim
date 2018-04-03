" Vim file detect for TiddlyWiki
" Language: tiddlywiki
" Maintainer: Devin Weaver <suki@tritarget.org>
" License: http://www.apache.org/licenses/LICENSE-2.0.txt

autocmd BufNewFile,BufRead *.tid  setf tiddlywiki
" :set includeexpr=v:fname.'.tid'
" setup tid file
autocmd BufNewFile,BufRead *.tid set includeexpr=v:fname.'.tid'
