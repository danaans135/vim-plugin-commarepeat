" vim:foldmethod=marker:fen:
scriptencoding utf-8

if exists('g:loaded_commarepeat') && g:loaded_commarepeat
    finish
endif
let g:loaded_commarepeat = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:CommaRepeat() range
  let alist = []
  let lnum = a:firstline
  while lnum <= a:lastline
    call extend(alist, s:Tempconv(split(getline(lnum), ",")))
    let lnum = lnum + 1
  endwhile
  let failed = append(line('$'), alist)
endfunction

function! s:Tempconv(olist)
  let alist = []
  for s in readfile($HOME."/Documents/GitHub/vim-plugin-commarepeat/plugin/test.txt")
    let s = substitute(s, "$0", a:olist[0], "")
    let s = substitute(s, "$1", a:olist[1], "")
    let s = substitute(s, "$2", a:olist[2], "")
    call add(alist, s)
  endfor
  return alist
endfunction

command! -range CommaRepeat :<line1>,<line2>call s:CommaRepeat()

let &cpo = s:save_cpo
