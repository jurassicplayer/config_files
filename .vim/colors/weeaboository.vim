"""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: Jurassicplayer
" Website: http://github.com/jurassicplayer
" Version: 0.3 - 10/19/15
"""""""""""""""""""""""""""""""""""""""""""""
" => Version History {{{
"""""""""""""""""""""""""""""""""""""""""""""
" v0.3 - Finished syntax group highlighting (10/19/15)
" v0.2 - Added colors for basic syntax and vim (10/16/15)
" v0.1 - Copied template colorscheme (10/15/15)
"""""""""""""""""""""""""""""""""""""""""""""}}}
" => Colorscheme {{{
"""""""""""""""""""""""""""""""""""""""""""""
let g:colors_name = "weeaboository"
if version > 580
    highlight clear
    if exists("syntax_on")
        syntax reset
    endif
endif
" TODO FIXME
" vim highlight groups {{{
hi ColorColumn                 cterm=NONE ctermfg=1 ctermbg=NONE gui=NONE guifg=#800000 guibg=NONE
highlight Conceal              cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Cursor                      cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guibg=NONE guifg=NONE
highlight CursorIM             cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight CursorColumn         cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi CursorLine                  cterm=NONE ctermfg=15 ctermbg=24 gui=NONE guifg=#ffffff guibg=#005f87
highlight Directory            cterm=NONE ctermfg=darkcyan ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight DiffAdd              cterm=NONE ctermfg=77 ctermbg=NONE gui=NONE guifg=77 guibg=NONE
highlight DiffChange           cterm=NONE ctermfg=172 ctermbg=NONE gui=NONE guifg=172 guibg=NONE
highlight DiffDelete           cterm=bold ctermfg=124 ctermbg=NONE gui=NONE guifg=124 guibg=NONE
highlight DiffText             cterm=bold ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight ErrorMsg             cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=#c0c0c0 guibg=#800000
hi VertSplit                   cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Folded                      cterm=NONE ctermfg=8 ctermbg=NONE gui=NONE guifg=#808080 guibg=NONE
highlight FoldColumn           cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight SignColumn           cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi IncSearch                   cterm=NONE ctermfg=0 ctermbg=220 gui=NONE guifg=#000000 guibg=#ffdf00
hi LineNr                      cterm=NONE ctermfg=24 ctermbg=234 gui=NONE guifg=#005f87 guibg=#1c1c1c
hi CursorLineNr                cterm=NONE ctermfg=15 ctermbg=24 gui=NONE guifg=#ffffff guibg=#005f87
highlight MatchParen           cterm=NONE ctermfg=236 ctermbg=104 gui=NONE guifg=236 guibg=104
highlight ModeMsg              cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight MoreMsg              cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight NonText              cterm=bold ctermfg=75 ctermbg=NONE gui=NONE guifg=75 guibg=NONE
hi Normal                      cterm=NONE ctermfg=255 ctermbg=235 gui=NONE guifg=255 guibg=235
hi Pmenu                       cterm=NONE ctermfg=15 ctermbg=60 gui=NONE guifg=#ffffff guibg=#5f5f87
hi PmenuSel                    cterm=bold ctermfg=15 ctermbg=24 gui=bold guifg=#ffffff guibg=#005f87
highlight PmenuSbar            cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight PmenuThumb           cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight Question             cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Search                      cterm=NONE ctermfg=234 ctermbg=208 gui=NONE guifg=#1c1c1c guibg=#ff8700
highlight SpecialKey           cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight SpellBad             cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight SpellCap             cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight SpellLocal           cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight SpellRare            cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi StatusLine                  cterm=bold ctermfg=15 ctermbg=234 gui=NONE guifg=#ffffff guibg=#1c1c1c
highlight StatusLineNC         cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight TabLineFill          cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight TabLineSel           cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight Title                cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Visual                      cterm=NONE ctermfg=255 ctermbg=103 gui=NONE guifg=255 guibg=103
highlight VisualNOS            cterm=bold,underline ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight WarningMsg           cterm=NONE ctermfg=214 ctermbg=NONE gui=NONE guifg=214 guibg=NONE
hi WildMenu                    cterm=NONE ctermfg=15 ctermbg=24 gui=NONE guifg=#ffffff guibg=#005f87
"}}}
" gui only highlighting groups {{{
hi Menu             gui=NONE guifg=NONE guibg=NONE
hi Scrollbar        gui=NONE guifg=NONE guibg=NONE
hi Tooltip          gui=NONE guifg=NONE guibg=NONE
"}}}
" syntax highlighting groups {{{
hi Comment          cterm=NONE ctermfg=117  ctermbg=NONE gui=NONE guifg=117  guibg=NONE
hi Constant         cterm=NONE ctermfg=77   ctermbg=NONE gui=NONE guifg=77   guibg=NONE
hi String           cterm=NONE ctermfg=71   ctermbg=NONE gui=NONE guifg=71   guibg=NONE
hi Character        cterm=NONE ctermfg=76   ctermbg=NONE gui=NONE guifg=76   guibg=NONE
hi Number           cterm=NONE ctermfg=203  ctermbg=NONE gui=NONE guifg=203  guibg=NONE
hi Boolean          cterm=NONE ctermfg=217  ctermbg=NONE gui=NONE guifg=217  guibg=NONE
hi Float            cterm=NONE ctermfg=203  ctermbg=NONE gui=NONE guifg=203  guibg=NONE
hi Identifier       cterm=NONE ctermfg=36   ctermbg=NONE gui=NONE guifg=36   guibg=NONE
hi Function         cterm=NONE ctermfg=31   ctermbg=NONE gui=NONE guifg=31   guibg=NONE
hi Statement        cterm=NONE ctermfg=140  ctermbg=NONE gui=NONE guifg=140  guibg=NONE
hi Conditional      cterm=NONE ctermfg=105  ctermbg=NONE gui=NONE guifg=105  guibg=NONE
hi Repeat           cterm=NONE ctermfg=99   ctermbg=NONE gui=NONE guifg=99   guibg=NONE
hi Label            cterm=NONE ctermfg=61   ctermbg=NONE gui=NONE guifg=61   guibg=NONE
hi Operator         cterm=NONE ctermfg=75   ctermbg=NONE gui=NONE guifg=75   guibg=NONE
hi Keyword          cterm=NONE ctermfg=147  ctermbg=NONE gui=NONE guifg=147  guibg=NONE
hi Exception        cterm=NONE ctermfg=214  ctermbg=NONE gui=NONE guifg=214  guibg=NONE
hi PreProc          cterm=NONE ctermfg=166  ctermbg=NONE gui=NONE guifg=166  guibg=NONE
hi Include          cterm=NONE ctermfg=208  ctermbg=NONE gui=NONE guifg=196  guibg=NONE
hi Define           cterm=NONE ctermfg=214  ctermbg=NONE gui=NONE guifg=196  guibg=NONE
hi Macro            cterm=NONE ctermfg=174  ctermbg=NONE gui=NONE guifg=174  guibg=NONE
hi PreCondit        cterm=NONE ctermfg=140  ctermbg=NONE gui=NONE guifg=140  guibg=NONE
hi Type             cterm=NONE ctermfg=106  ctermbg=NONE gui=NONE guifg=106  guibg=NONE
hi StorageClass     cterm=NONE ctermfg=112  ctermbg=NONE gui=NONE guifg=112  guibg=NONE
hi Structure        cterm=NONE ctermfg=106  ctermbg=NONE gui=NONE guifg=106  guibg=NONE
hi Typedef          cterm=NONE ctermfg=100  ctermbg=NONE gui=NONE guifg=100  guibg=NONE
hi Special          cterm=NONE ctermfg=177  ctermbg=NONE gui=NONE guifg=177  guibg=NONE
hi SpecialChar      cterm=NONE ctermfg=183  ctermbg=NONE gui=NONE guifg=183  guibg=NONE
hi Tag              cterm=NONE ctermfg=77   ctermbg=NONE gui=NONE guifg=77   guibg=NONE
hi Delimiter        cterm=NONE ctermfg=83   ctermbg=NONE gui=NONE guifg=83   guibg=NONE
hi SpecialComment   cterm=NONE ctermfg=34   ctermbg=NONE gui=NONE guifg=34   guibg=NONE
hi Debug            cterm=NONE ctermfg=227  ctermbg=NONE gui=NONE guifg=227  guibg=NONE
hi Underlined       cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Ignore           cterm=bold ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Error            cterm=bold ctermfg=NONE ctermbg=124  gui=NONE guifg=NONE guibg=124
hi Todo             cterm=bold ctermfg=234  ctermbg=178  gui=NONE guifg=234 guibg=178
"}}}

"""""""""""""""""""""""""""""""""""""""""""""
"}}} vim:foldmethod=marker:foldlevel=0
