" -----------------------------------------------------------------------------
" File: mechanica.vim
" Description: Hi-tech mechanical color scheme for Vim
" Author: alexpro <aleksandar.prokopec@gmail.com>
" Source: https://github.com/axel22/mechanica
" Last Modified: 20 Feb 2020
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='mechanica'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:mechanica_bold')
  let g:mechanica_bold=1
endif
if !exists('g:mechanica_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:mechanica_italic=1
  else
    let g:mechanica_italic=0
  endif
endif
if !exists('g:mechanica_undercurl')
  let g:mechanica_undercurl=1
endif
if !exists('g:mechanica_underline')
  let g:mechanica_underline=1
endif
if !exists('g:mechanica_inverse')
  let g:mechanica_inverse=1
endif

if !exists('g:mechanica_guisp_fallback') || index(['fg', 'bg'], g:mechanica_guisp_fallback) == -1
  let g:mechanica_guisp_fallback='NONE'
endif

if !exists('g:mechanica_improved_strings')
  let g:mechanica_improved_strings=0
endif

if !exists('g:mechanica_improved_warnings')
  let g:mechanica_improved_warnings=0
endif

if !exists('g:mechanica_termcolors')
  let g:mechanica_termcolors=256
endif

if !exists('g:mechanica_invert_indent_guides')
  let g:mechanica_invert_indent_guides=0
endif

if exists('g:mechanica_contrast')
  echo 'g:mechanica_contrast is deprecated; use g:mechanica_contrast_light and g:mechanica_contrast_dark instead'
endif

if !exists('g:mechanica_contrast_dark')
  let g:mechanica_contrast_dark='medium'
endif

if !exists('g:mechanica_contrast_light')
  let g:mechanica_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0_hard  = ['#1d2021', 234]     " 29-32-33
let s:gb.dark0       = ['#282828', 235]     " 40-40-40
let s:gb.dark0_soft  = ['#32302f', 236]     " 50-48-47
let s:gb.dark1       = ['#3c3836', 237]     " 60-56-54
let s:gb.dark2       = ['#504945', 239]     " 80-73-69
let s:gb.dark3       = ['#665c54', 241]     " 102-92-84
let s:gb.dark4       = ['#7c6f64', 243]     " 124-111-100
let s:gb.dark4_256   = ['#7c6f64', 243]     " 124-111-100

let s:gb.gray_245    = ['#928374', 245]     " 146-131-116
let s:gb.gray_244    = ['#928374', 244]     " 146-131-116

let s:gb.light0_hard = ['#f9f5d7', 230]     " 249-245-215
let s:gb.light0      = ['#fbf1c7', 229]     " 253-244-193
let s:gb.light0_soft = ['#f2e5bc', 228]     " 242-229-188
let s:gb.light1      = ['#e0dbd2', 223]
let s:gb.light2      = ['#d5c4a1', 250]     " 213-196-161
let s:gb.light3      = ['#bdae93', 248]     " 189-174-147
let s:gb.light4      = ['#a89984', 246]     " 168-153-132
let s:gb.light4_256  = ['#a89984', 246]     " 168-153-132

let s:gb.bright_red     = ['#fb4934', 167]     " 251-73-52
let s:gb.bright_green   = ['#1db81d', 142]
let s:gb.bright_yellow  = ['#ffcb3d', 214]
let s:gb.bright_blue    = ['#1ea0d4', 74]
let s:gb.bright_purple  = ['#d3869b', 175]     " 211-134-155
let s:gb.bright_aqua    = ['#8ec07c', 108]     " 142-192-124
let s:gb.bright_orange  = ['#e38539', 208]

let s:gb.neutral_red    = ['#cc241d', 124]     " 204-36-29
let s:gb.neutral_green  = ['#98971a', 106]     " 152-151-26
let s:gb.neutral_yellow = ['#d79921', 172]     " 215-153-33
let s:gb.neutral_blue   = ['#22699c', 32]
let s:gb.neutral_purple = ['#b16286', 132]     " 177-98-134
let s:gb.neutral_aqua   = ['#689d6a', 72]      " 104-157-106
let s:gb.neutral_orange = ['#d65d0e', 166]     " 214-93-14

let s:gb.faded_red      = ['#9d0006', 88]      " 157-0-6
let s:gb.faded_green    = ['#79740e', 100]     " 121-116-14
let s:gb.faded_yellow   = ['#b57614', 136]     " 181-118-20
let s:gb.faded_blue     = ['#204d6e', 25]
let s:gb.faded_purple   = ['#8f3f71', 96]      " 143-63-113
let s:gb.faded_aqua     = ['#427b58', 66]      " 66-123-88
let s:gb.faded_orange   = ['#af3a03', 130]     " 175-58-3

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:mechanica_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:mechanica_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:mechanica_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:mechanica_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:mechanica_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:mechanica_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:mechanica_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:mechanica_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:mechanica_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:mechanica_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.purple = s:purple
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:purple[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:aqua[0]

  let g:terminal_color_7 = s:fg4[0]
  let g:terminal_color_15 = s:fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:mechanica_hls_cursor')
  let s:hls_cursor = get(s:gb, g:mechanica_hls_cursor)
endif

let s:number_column = s:none
if exists('g:mechanica_number_column')
  let s:number_column = get(s:gb, g:mechanica_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:mechanica_sign_column')
    let s:sign_column = get(s:gb, g:mechanica_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:mechanica_color_column')
  let s:color_column = get(s:gb, g:mechanica_color_column)
endif

let s:vert_split = s:bg0
if exists('g:mechanica_vert_split')
  let s:vert_split = get(s:gb, g:mechanica_vert_split)
endif

let s:invert_signs = ''
if exists('g:mechanica_invert_signs')
  if g:mechanica_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:mechanica_invert_selection')
  if g:mechanica_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:mechanica_invert_tabline')
  if g:mechanica_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:mechanica_italicize_comments')
  if g:mechanica_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:mechanica_italicize_strings')
  if g:mechanica_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:mechanica_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:mechanica_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Mechanica Hi Groups: {{{

" memoize common hi groups
call s:HL('MechanicaFg0', s:fg0)
call s:HL('MechanicaFg1', s:fg1)
call s:HL('MechanicaFg2', s:fg2)
call s:HL('MechanicaFg3', s:fg3)
call s:HL('MechanicaFg4', s:fg4)
call s:HL('MechanicaGray', s:gray)
call s:HL('MechanicaBg0', s:bg0)
call s:HL('MechanicaBg1', s:bg1)
call s:HL('MechanicaBg2', s:bg2)
call s:HL('MechanicaBg3', s:bg3)
call s:HL('MechanicaBg4', s:bg4)

call s:HL('MechanicaRed', s:red)
call s:HL('MechanicaRedBold', s:red, s:none, s:bold)
call s:HL('MechanicaGreen', s:green)
call s:HL('MechanicaGreenBold', s:green, s:none, s:bold)
call s:HL('MechanicaYellow', s:yellow)
call s:HL('MechanicaYellowBold', s:yellow, s:none, s:bold)
call s:HL('MechanicaBlue', s:blue)
call s:HL('MechanicaBlueBold', s:blue, s:none, s:bold)
call s:HL('MechanicaPurple', s:purple)
call s:HL('MechanicaPurpleBold', s:purple, s:none, s:bold)
call s:HL('MechanicaAqua', s:aqua)
call s:HL('MechanicaAquaBold', s:aqua, s:none, s:bold)
call s:HL('MechanicaOrange', s:orange)
call s:HL('MechanicaOrangeBold', s:orange, s:none, s:bold)

call s:HL('MechanicaRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('MechanicaGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('MechanicaYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('MechanicaBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('MechanicaPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('MechanicaAquaSign', s:aqua, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/gruvbox/issues/7
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg1)
endif

hi! link NonText MechanicaBg2
hi! link SpecialKey MechanicaBg2

call s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:blue, s:none, s:underline)

call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory MechanicaGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title MechanicaGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg MechanicaYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg MechanicaYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question MechanicaOrangeBold
" Warning messages
hi! link WarningMsg MechanicaRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:mechanica_improved_strings == 0
  hi! link Special MechanicaOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement MechanicaBlue
" if, then, else, endif, swicth, etc.
hi! link Conditional MechanicaBlue
" for, do, while, etc.
hi! link Repeat MechanicaBlue
" case, default, etc.
hi! link Label MechanicaBlue
" try, catch, throw
hi! link Exception MechanicaBlue
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword MechanicaBlue

" Variable name
hi! link Identifier Normal
" Function name
hi! link Function MechanicaYellow

" Generic preprocessor
hi! link PreProc MechanicaAqua
" Preprocessor #include
hi! link Include MechanicaBlue
" Preprocessor #define
hi! link Define MechanicaAqua
" Same as Define
hi! link Macro MechanicaAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit MechanicaAqua

" Generic constant
hi! link Constant MechanicaPurple
" Character constant: 'c', '/n'
hi! link Character MechanicaPurple
" String constant: "this is a string"
if g:mechanica_improved_strings == 0
  call s:HL('String',  s:orange, s:none, s:italicize_strings)
else
  call s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean MechanicaPurple
" Number constant: 234, 0xff
hi! link Number MechanicaPurple
" Floating point constant: 2.3e10
hi! link Float MechanicaPurple

" Generic type
hi! link Type MechanicaGreen
" static, register, volatile, etc
hi! link StorageClass MechanicaBlue
" struct, union, enum, etc.
hi! link Structure MechanicaBlue
" typedef
hi! link Typedef MechanicaBlue

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:mechanica_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:mechanica_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd MechanicaGreenSign
hi! link GitGutterChange MechanicaYellowSign
hi! link GitGutterDelete MechanicaRedSign
hi! link GitGutterChangeDelete MechanicaAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile MechanicaGreen
hi! link gitcommitDiscardedFile MechanicaRed

" }}}
" Signify: {{{

hi! link SignifySignAdd MechanicaGreenSign
hi! link SignifySignChange MechanicaAquaSign
hi! link SignifySignDelete MechanicaRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign MechanicaRedSign
hi! link SyntasticWarningSign MechanicaYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   MechanicaBlueSign
hi! link SignatureMarkerText MechanicaPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl MechanicaBlueSign
hi! link ShowMarksHLu MechanicaBlueSign
hi! link ShowMarksHLo MechanicaBlueSign
hi! link ShowMarksHLm MechanicaBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch MechanicaYellow
hi! link CtrlPNoEntries MechanicaRed
hi! link CtrlPPrtBase MechanicaBg2
hi! link CtrlPPrtCursor MechanicaBlue
hi! link CtrlPLinePre MechanicaBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket MechanicaFg3
hi! link StartifyFile MechanicaFg1
hi! link StartifyNumber MechanicaBlue
hi! link StartifyPath MechanicaGray
hi! link StartifySlash MechanicaGray
hi! link StartifySection MechanicaYellow
hi! link StartifySpecial MechanicaBg2
hi! link StartifyHeader MechanicaOrange
hi! link StartifyFooter MechanicaBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}
" Asynchronous Lint Engine: {{{

call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

hi! link ALEErrorSign MechanicaRedSign
hi! link ALEWarningSign MechanicaYellowSign
hi! link ALEInfoSign MechanicaBlueSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail MechanicaAqua
hi! link DirvishArg MechanicaYellow

" }}}
" Netrw: {{{

hi! link netrwDir MechanicaAqua
hi! link netrwClassify MechanicaAqua
hi! link netrwLink MechanicaGray
hi! link netrwSymLink MechanicaFg1
hi! link netrwExe MechanicaYellow
hi! link netrwComment MechanicaGray
hi! link netrwList MechanicaBlue
hi! link netrwHelpCmd MechanicaAqua
hi! link netrwCmdSep MechanicaFg3
hi! link netrwVersion MechanicaGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir MechanicaAqua
hi! link NERDTreeDirSlash MechanicaAqua

hi! link NERDTreeOpenable MechanicaOrange
hi! link NERDTreeClosable MechanicaOrange

hi! link NERDTreeFile MechanicaFg1
hi! link NERDTreeExecFile MechanicaYellow

hi! link NERDTreeUp MechanicaGray
hi! link NERDTreeCWD MechanicaGreen
hi! link NERDTreeHelp MechanicaFg1

hi! link NERDTreeToggleOn MechanicaGreen
hi! link NERDTreeToggleOff MechanicaRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded MechanicaGreen
hi! link diffRemoved MechanicaRed
hi! link diffChanged MechanicaAqua

hi! link diffFile MechanicaOrange
hi! link diffNewFile MechanicaYellow

hi! link diffLine MechanicaBlue

" }}}
" Html: {{{

hi! link htmlTag MechanicaBlue
hi! link htmlEndTag MechanicaBlue

hi! link htmlTagName MechanicaBlue
hi! link htmlArg Normal

hi! link htmlScriptTag MechanicaBlue
hi! link htmlTagN MechanicaFg1
hi! link htmlSpecialTagName MechanicaBlue

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar MechanicaOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag MechanicaBlue
hi! link xmlEndTag MechanicaBlue
hi! link xmlTagName MechanicaBlue
hi! link xmlEqual MechanicaBlue
hi! link docbkKeyword MechanicaAquaBold

hi! link xmlDocTypeDecl MechanicaGray
hi! link xmlDocTypeKeyword MechanicaPurple
hi! link xmlCdataStart MechanicaGray
hi! link xmlCdataCdata MechanicaPurple
hi! link dtdFunction MechanicaGray
hi! link dtdTagName MechanicaPurple

hi! link xmlAttrib MechanicaAqua
hi! link xmlProcessingDelim MechanicaGray
hi! link dtdParamEntityPunct MechanicaGray
hi! link dtdParamEntityDPunct MechanicaGray
hi! link xmlAttribPunct MechanicaGray

hi! link xmlEntity MechanicaOrange
hi! link xmlEntityPunct MechanicaOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation MechanicaOrange
hi! link vimBracket MechanicaOrange
hi! link vimMapModKey MechanicaOrange
hi! link vimFuncSID MechanicaFg3
hi! link vimSetSep MechanicaFg3
hi! link vimSep MechanicaFg3
hi! link vimContinue MechanicaFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword MechanicaBlue
hi! link clojureCond MechanicaOrange
hi! link clojureSpecial MechanicaOrange
hi! link clojureDefine MechanicaOrange

hi! link clojureFunc MechanicaYellow
hi! link clojureRepeat MechanicaYellow
hi! link clojureCharacter MechanicaAqua
hi! link clojureStringEscape MechanicaAqua
hi! link clojureException MechanicaRed

hi! link clojureRegexp MechanicaAqua
hi! link clojureRegexpEscape MechanicaAqua
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen MechanicaFg3
hi! link clojureAnonArg MechanicaYellow
hi! link clojureVariable MechanicaBlue
hi! link clojureMacro MechanicaOrange

hi! link clojureMeta MechanicaYellow
hi! link clojureDeref MechanicaYellow
hi! link clojureQuote MechanicaYellow
hi! link clojureUnquote MechanicaYellow

" }}}
" C: {{{

hi! link cOperator MechanicaPurple
hi! link cStructure MechanicaGreen

" }}}
" Python: {{{

hi! link pythonBuiltin MechanicaOrange
hi! link pythonBuiltinObj MechanicaOrange
hi! link pythonBuiltinFunc MechanicaOrange
hi! link pythonFunction MechanicaAqua
hi! link pythonDecorator MechanicaRed
hi! link pythonInclude MechanicaBlue
hi! link pythonImport MechanicaBlue
hi! link pythonRun MechanicaBlue
hi! link pythonCoding MechanicaBlue
hi! link pythonOperator MechanicaBlue
hi! link pythonException MechanicaRed
hi! link pythonExceptions MechanicaPurple
hi! link pythonBoolean MechanicaPurple
hi! link pythonDot MechanicaFg3
hi! link pythonConditional MechanicaBlue
hi! link pythonRepeat MechanicaBlue
hi! link pythonDottedName MechanicaGreen

" }}}
" CSS: {{{

hi! link cssBraces Normal
hi! link cssFunctionName MechanicaYellow
hi! link cssIdentifier MechanicaOrange
hi! link cssClassName MechanicaGreen
hi! link cssColor MechanicaPurple
hi! link cssSelectorOp MechanicaGreen
hi! link cssSelectorOp2 MechanicaGreen
hi! link cssImportant MechanicaGreen
hi! link cssVendor MechanicaFg1

hi! link cssTextProp MechanicaAqua
hi! link cssAnimationProp MechanicaAqua
hi! link cssUIProp MechanicaAqua
hi! link cssTransformProp MechanicaAqua
hi! link cssTransitionProp MechanicaAqua
hi! link cssPrintProp MechanicaAqua
hi! link cssPositioningProp MechanicaAqua
hi! link cssBoxProp MechanicaAqua
hi! link cssFontDescriptorProp MechanicaAqua
hi! link cssFlexibleBoxProp MechanicaAqua
hi! link cssBorderOutlineProp MechanicaAqua
hi! link cssBackgroundProp MechanicaAqua
hi! link cssMarginProp MechanicaAqua
hi! link cssListProp MechanicaAqua
hi! link cssTableProp MechanicaAqua
hi! link cssFontProp MechanicaAqua
hi! link cssPaddingProp MechanicaAqua
hi! link cssDimensionProp MechanicaAqua
hi! link cssRenderProp MechanicaAqua
hi! link cssColorProp MechanicaAqua
hi! link cssGeneratedContentProp MechanicaAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces MechanicaFg1
hi! link javaScriptFunction MechanicaYellow
hi! link javaScriptIdentifier Normal
hi! link javaScriptMember Normal
hi! link javaScriptNumber MechanicaPurple
hi! link javaScriptNull MechanicaPurple
hi! link javaScriptParens MechanicaFg3

" }}}
" YAJS: {{{

hi! link javascriptImport MechanicaBlue
hi! link javascriptExport MechanicaBlue
hi! link javascriptClassKeyword MechanicaBlue
hi! link javascriptClassExtends MechanicaBlue
hi! link javascriptDefault MechanicaAqua

hi! link javascriptClassName MechanicaYellow
hi! link javascriptClassSuperName MechanicaYellow
hi! link javascriptGlobal Normal

hi! link javascriptEndColons MechanicaFg1
hi! link javascriptFuncArg MechanicaFg1
hi! link javascriptGlobalMethod MechanicaFg1
hi! link javascriptNodeGlobal MechanicaFg1
hi! link javascriptBOMWindowProp MechanicaFg1
hi! link javascriptArrayMethod MechanicaFg1
hi! link javascriptArrayStaticMethod MechanicaFg1
hi! link javascriptCacheMethod MechanicaFg1
hi! link javascriptDateMethod MechanicaFg1
hi! link javascriptMathStaticMethod MechanicaFg1

" hi! link javascriptProp MechanicaFg1
hi! link javascriptURLUtilsProp MechanicaFg1
hi! link javascriptBOMNavigatorProp MechanicaFg1
hi! link javascriptDOMDocMethod MechanicaFg1
hi! link javascriptDOMDocProp MechanicaFg1
hi! link javascriptBOMLocationMethod MechanicaFg1
hi! link javascriptBOMWindowMethod MechanicaFg1
hi! link javascriptStringMethod MechanicaFg1

hi! link javascriptVariable Normal
" hi! link javascriptVariable MechanicaRed
" hi! link javascriptIdentifier MechanicaOrange
" hi! link javascriptClassSuper MechanicaOrange
hi! link javascriptIdentifier Normal
hi! link javascriptClassSuper MechanicaOrange

" hi! link javascriptFuncKeyword MechanicaOrange
" hi! link javascriptAsyncFunc MechanicaOrange
hi! link javascriptFuncKeyword MechanicaAqua
hi! link javascriptAsyncFunc MechanicaAqua
hi! link javascriptClassStatic MechanicaOrange

hi! link javascriptOperator MechanicaBlue
hi! link javascriptForOperator MechanicaBlue
hi! link javascriptYield MechanicaBlue
hi! link javascriptExceptions MechanicaRed
hi! link javascriptMessage MechanicaRed

hi! link javascriptTemplateSB MechanicaAqua
hi! link javascriptTemplateSubstitution MechanicaFg1

" hi! link javascriptLabel MechanicaBlue
" hi! link javascriptObjectLabel MechanicaBlue
hi! link javascriptPropertyName Normal
hi! link javascriptLabel MechanicaFg1
hi! link javascriptObjectLabel MechanicaFg1
hi! link javascriptPropertyName MechanicaFg1

hi! link javascriptLogicSymbols MechanicaFg1
hi! link javascriptArrowFunc MechanicaYellow

hi! link javascriptDocParamName MechanicaFg4
hi! link javascriptDocTags MechanicaFg4
hi! link javascriptDocNotation MechanicaFg4
hi! link javascriptDocParamType MechanicaFg4
hi! link javascriptDocNamedParamType MechanicaFg4

hi! link javascriptBrackets MechanicaFg1
hi! link javascriptDOMElemAttrs MechanicaFg1
hi! link javascriptDOMEventMethod MechanicaFg1
hi! link javascriptDOMNodeMethod MechanicaFg1
hi! link javascriptDOMStorageMethod MechanicaFg1
hi! link javascriptHeadersMethod MechanicaFg1

hi! link javascriptAsyncFuncKeyword MechanicaBlue
hi! link javascriptAwaitFuncKeyword MechanicaBlue

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword MechanicaAqua
hi! link jsExtendsKeyword MechanicaAqua
hi! link jsExportDefault MechanicaAqua
hi! link jsTemplateBraces MechanicaAqua
hi! link jsGlobalNodeObjects MechanicaFg1
hi! link jsGlobalObjects MechanicaFg1
hi! link jsFunction MechanicaAqua
hi! link jsFuncParens MechanicaFg3
hi! link jsParens MechanicaFg3
hi! link jsNull MechanicaPurple
hi! link jsUndefined MechanicaPurple
hi! link jsClassDefinition MechanicaYellow

" }}}
" TypeScript: {{{

hi! link typeScriptReserved MechanicaAqua
hi! link typeScriptLabel MechanicaAqua
hi! link typeScriptFuncKeyword MechanicaAqua
hi! link typeScriptIdentifier MechanicaOrange
hi! link typeScriptBraces MechanicaFg1
hi! link typeScriptEndColons MechanicaFg1
hi! link typeScriptDOMObjects MechanicaFg1
hi! link typeScriptAjaxMethods MechanicaFg1
hi! link typeScriptLogicSymbols MechanicaFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects MechanicaFg1
hi! link typeScriptParens MechanicaFg3
hi! link typeScriptOpSymbols MechanicaFg3
hi! link typeScriptHtmlElemProperties MechanicaFg1
hi! link typeScriptNull MechanicaPurple
hi! link typeScriptInterpolationDelimiter MechanicaAqua

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword MechanicaAqua
hi! link purescriptModuleName MechanicaFg1
hi! link purescriptWhere MechanicaAqua
hi! link purescriptDelimiter MechanicaFg4
hi! link purescriptType MechanicaFg1
hi! link purescriptImportKeyword MechanicaAqua
hi! link purescriptHidingKeyword MechanicaAqua
hi! link purescriptAsKeyword MechanicaAqua
hi! link purescriptStructure MechanicaAqua
hi! link purescriptOperator MechanicaBlue

hi! link purescriptTypeVar MechanicaFg1
hi! link purescriptConstructor MechanicaFg1
hi! link purescriptFunction MechanicaFg1
hi! link purescriptConditional MechanicaOrange
hi! link purescriptBacktick MechanicaOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp MechanicaFg3
hi! link coffeeSpecialOp MechanicaFg3
hi! link coffeeCurly MechanicaOrange
hi! link coffeeParen MechanicaFg3
hi! link coffeeBracket MechanicaOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter MechanicaGreen
hi! link rubyInterpolationDelimiter MechanicaAqua

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier MechanicaRed
hi! link objcDirective MechanicaBlue

" }}}
" Go: {{{

hi! link goDirective MechanicaAqua
hi! link goConstants MechanicaPurple
hi! link goDeclaration MechanicaRed
hi! link goDeclType MechanicaBlue
hi! link goBuiltins MechanicaOrange

" }}}
" Lua: {{{

hi! link luaIn MechanicaRed
hi! link luaFunction MechanicaAqua
hi! link luaTable MechanicaOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp MechanicaFg3
hi! link moonExtendedOp MechanicaFg3
hi! link moonFunction MechanicaFg3
hi! link moonObject MechanicaYellow

" }}}
" Java: {{{

hi! link javaAnnotation MechanicaRed
hi! link javaDocTags MechanicaAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen MechanicaFg3
hi! link javaParen1 MechanicaFg3
hi! link javaParen2 MechanicaFg3
hi! link javaParen3 MechanicaFg3
hi! link javaParen4 MechanicaFg3
hi! link javaParen5 MechanicaFg3
hi! link javaOperator MechanicaBlue

hi! link javaVarArg MechanicaGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter MechanicaGreen
hi! link elixirInterpolationDelimiter MechanicaAqua

hi! link elixirModuleDeclaration MechanicaYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition MechanicaFg1
hi! link scalaCaseFollowing MechanicaFg1
hi! link scalaCapitalWord MechanicaFg1
hi! link scalaTypeExtension MechanicaFg1

hi! link scalaKeyword MechanicaBlue
hi! link scalaKeywordModifier MechanicaBlue

hi! link scalaSpecial MechanicaAqua
hi! link scalaOperator MechanicaFg1

hi! link scalaTypeDeclaration MechanicaBlue
hi! link scalaTypeTypePostDeclaration MechanicaBlue

hi! link scalaInstanceDeclaration MechanicaFg1
hi! link scalaInterpolation MechanicaOrange

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 MechanicaGreenBold
hi! link markdownH2 MechanicaGreenBold
hi! link markdownH3 MechanicaYellowBold
hi! link markdownH4 MechanicaYellowBold
hi! link markdownH5 MechanicaYellow
hi! link markdownH6 MechanicaYellow

hi! link markdownCode MechanicaAqua
hi! link markdownCodeBlock MechanicaAqua
hi! link markdownCodeDelimiter MechanicaAqua

hi! link markdownBlockquote MechanicaGray
hi! link markdownListMarker MechanicaGray
hi! link markdownOrderedListMarker MechanicaGray
hi! link markdownRule MechanicaGray
hi! link markdownHeadingRule MechanicaGray

hi! link markdownUrlDelimiter MechanicaFg3
hi! link markdownLinkDelimiter MechanicaFg3
hi! link markdownLinkTextDelimiter MechanicaFg3

hi! link markdownHeadingDelimiter MechanicaOrange
hi! link markdownUrl MechanicaPurple
hi! link markdownUrlTitleDelimiter MechanicaGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType MechanicaYellow
" hi! link haskellOperators MechanicaOrange
" hi! link haskellConditional MechanicaAqua
" hi! link haskellLet MechanicaOrange
"
hi! link haskellType MechanicaFg1
hi! link haskellIdentifier MechanicaFg1
hi! link haskellSeparator MechanicaFg1
hi! link haskellDelimiter MechanicaFg4
hi! link haskellOperators MechanicaBlue
"
hi! link haskellBacktick MechanicaOrange
hi! link haskellStatement MechanicaOrange
hi! link haskellConditional MechanicaOrange

hi! link haskellLet MechanicaAqua
hi! link haskellDefault MechanicaAqua
hi! link haskellWhere MechanicaAqua
hi! link haskellBottom MechanicaAqua
hi! link haskellBlockKeywords MechanicaAqua
hi! link haskellImportKeywords MechanicaAqua
hi! link haskellDeclKeyword MechanicaAqua
hi! link haskellDeriving MechanicaAqua
hi! link haskellAssocType MechanicaAqua

hi! link haskellNumber MechanicaPurple
hi! link haskellPragma MechanicaPurple

hi! link haskellString MechanicaGreen
hi! link haskellChar MechanicaGreen

" }}}
" Json: {{{

hi! link jsonKeyword MechanicaGreen
hi! link jsonQuote MechanicaGreen
hi! link jsonBraces MechanicaFg1
hi! link jsonString MechanicaFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! MechanicaHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! MechanicaHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
