" -----------------------------------------------------------------------------
" File: mechanica.vim
" Description: Hi-tech mechanical color scheme for Vim
" Author: alexpro <aleksandar.prokopec@gmail.com>
" Source: https://github.com/axel22/mechanica
" Last Modified: 20 Feb 2020
" -----------------------------------------------------------------------------

function! mechanica#invert_signs_toggle()
  if g:mechanica_invert_signs == 0
    let g:mechanica_invert_signs=1
  else
    let g:mechanica_invert_signs=0
  endif

  colorscheme mechanica
endfunction

" Search Highlighting {{{

function! mechanica#hls_show()
  set hlsearch
  call MechanicaHlsShowCursor()
endfunction

function! mechanica#hls_hide()
  set nohlsearch
  call MechanicaHlsHideCursor()
endfunction

function! mechanica#hls_toggle()
  if &hlsearch
    call mechanica#hls_hide()
  else
    call mechanica#hls_show()
  endif
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
