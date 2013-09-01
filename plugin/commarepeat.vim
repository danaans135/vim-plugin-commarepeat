" vim:foldmethod=marker:fen:
scriptencoding utf-8

"if exists('g:loaded_commarepeat') && g:loaded_commarepeat
"    finish
"endif
"let g:loaded_commarepeat = 1

let s:save_cpo = &cpo
set cpo&vim

" Functions {{{
"s:CommaRepeat {{{
function! s:CommaRepeat(type) range
  "echo a:type
  let basedir = $HOME."/Documents/GitHub/vim-plugin-commarepeat/plugin/"
  let filename = basedir . a:type . ".txt"
  let tmpllines = readfile(filename)

  let alist = []
  let lnum = a:firstline
  while lnum <= a:lastline
    call extend(alist, s:Tempconv(tmpllines,
\      split(getline(lnum), ",")))
    let lnum = lnum + 1
  endwhile
  let failed = append(line('$'), alist)
endfunction

"}}}
"s:Tempconv {{{
function! s:Tempconv(tmpllines, olist)
  let alist = []
  for s in a:tmpllines
    let s = iconv(s, "utf-8", &enc)
    let s = substitute(s, "$0", a:olist[0], "")
    let s = substitute(s, "$1", a:olist[1], "")
    let s = substitute(s, "$2", a:olist[2], "")
    call add(alist, s)
  endfor
  return alist
endfunction

"}}}
"s:CmplList {{{
function! CmplList(A,L,P)
  return ["test"]
endfunction

"}}}
"}}}

command! -nargs=1 -range -complete=customlist,CmplList CommaRepeat :<line1>,<line2>call s:CommaRepeat(<q-args>)

let &cpo = s:save_cpo
