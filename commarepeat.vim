" vim:foldmethod=marker:fen:
scriptencoding utf-8

"if exists('g:loaded_commarepeat') && g:loaded_commarepeat
"    finish
"endif
"let g:loaded_commarepeat = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:CommaRepeat() range
  let alist = []
  let lnum = a:firstline
  while lnum <= a:lastline
    let elems = split(getline(lnum), ",")
    call add(alist, "Public Property " . elems[0] . " As " . elems[1])
    call add(alist, "    Get")
    call add(alist, "        Return _" . elems[0])
    call add(alist, "    End Get")
    call add(alist, "End Property")
    let lnum = lnum + 1
  endwhile
  let failed = append(line('$'), alist)
endfunction
"
command! -range CommaRepeat :<line1>,<line2>call s:CommaRepeat()

let &cpo = s:save_cpo
