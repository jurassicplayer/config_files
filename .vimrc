"""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: Jurassicplayer
" Website: http://github.com/jurassicplayer
" Version: 1.0 - 09/21/15
"""""""""""""""""""""""""""""""""""""""""""""
" => Version History {{{
"""""""""""""""""""""""""""""""""""""""""""""
" v1.0 - Initial commit
" v0.9 - Added/configured gundo plugin and added various keymappings
" v0.8 - Configured unite plugin
" v0.7 - Added neocomplete and unite plugins
" v0.6 - Changed from vundle to NeoBundle
" v0.5 - Added a variety of plugins (including Vundle)
" v0.4 - Configured vim-airline
" v0.3 - Configured vim settings
" v0.2 - Various changes to formatting, plugins
" v0.1 - Initial settings (9/18/15)
"""""""""""""""""""""""""""""""""""""""""""""}}}
" => NeoBundle Plugin Manager {{{
"""""""""""""""""""""""""""""""""""""""""""""
" Setup and init NeoBundle
if has('vim_starting')
    if &compatible
        set nocompatible
    endif
    set runtimepath+=~/.vim/bundle/neobundle.vim
    filetype off
endif
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Plugins List
NeoBundle 'bling/vim-airline'
NeoBundle 'chrisbra/SudoEdit.vim'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'dhruvasagar/vim-vinegar'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'KabbAmine/vCoolor.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', {'build' : {'windows' : 'tools\\update-dll-mingw', 'cygwin' : 'make -f make_cygwin.mak', 'mac' : 'make -f make_mac.mak', 'linux' : 'make', 'unix' : 'gmake',},}
NeoBundle 'sjl/gundo.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vimwiki/vimwiki', {'branch' : 'dev'}
NeoBundle 'wincent/terminus'

" Finish neobundle init
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"""""""""""""""""""""""""""""""""""""""""""""}}}
" => General {{{        
""""""""""""""""""""""""""""""""""""""""""""" 
" Disable viminfo
set viminfo="NONE"

" The number of lines of command history to remember
set history=20

" Autoread when a file is changed from an external program
set autoread

" Don't redraw while executing macros
set lazyredraw

" Set utf8 as standard encoding 
set encoding=utf8

" No sounds on errors
set belloff=backspace,cursor,error,esc,insertmode

" Don't show a visual bell
set novisualbell

" Check the last line of the file for a modeline
set modelines=1

"""""""""""""""""""""""""""""""""""""""""""""}}}
" => Key Maps {{{
"""""""""""""""""""""""""""""""""""""""""""""
" Remap leader key to ,
let mapleader = ","

" Quick access .vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
" Quick reload .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Quick navigation (quickfix/buffer/tab)
map ]q :cnext<cr>
map [q :cprevious<cr>
map ]b :bnext<cr>
map [b :bprevious<cr>
map ]t :tabnext<cr>
map [t :tabprevious<cr>

" Visual line movement
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj

" Replace beginning/end of word to beginning/end of sentence
nnoremap B ^
nnoremap E $

" Map ESC to jk
inoremap jk <esc>

" Map <leader>, to <leader>c<space> for NERDCommenter toggle
map <leader>, <leader>c<space>

" Highlight last inserted text
nnoremap gV `[v`]

" Remove search highlight
nnoremap <leader><space> :nohlsearch<cr>

" Toggle paste mode
map <leader>p :setlocal paste!<cr>

" Toggle folds
nnoremap <tab> za

"""""""""""""""""""""""""""""""""""""""""""""}}}
" => Vim UI {{{
"""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Enable folding
set foldenable
set foldlevelstart=10
set foldmethod=indent

" Mark ideal max text width
"set colorcolumn+=100

" Highlight matching brace
set showmatch

" Hide original showmode for vim-airline
set noshowmode

" Always show the status line
set laststatus=2

" Show a visual dmenu-like auto-complete
set wildmenu
set wildmode=longest:full,full
" Filetypes to ignore
set wildignore=*~,*.bak,*.o,*.pyc,*.swp

" Configure backspace to wrap normally
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Show numbered lines on the left margin
set number

" Show current line/column position in file
set noruler

" Enable mouse if mouse support compiled
if has('mouse')
    set mouse=a
endif

"""""""""""""""""""""""""""""""""""""""""""""}}}
" => Search {{{
"""""""""""""""""""""""""""""""""""""""""""""
" Ignore case when searching
set ignorecase

" Try to be smart about cases when searching
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

"""""""""""""""""""""""""""""""""""""""""""""}}}
" => Colors {{{
"""""""""""""""""""""""""""""""""""""""""""""
try 
    colorscheme desert
catch
endtry

set background=dark

" Use 256 colors in terminal
if !has("gui_running")
    set t_Co=256
    set term=screen-256color
endif

" Highlight current line
set cursorline
hi CursorLine cterm=NONE ctermbg=24 ctermfg=white guibg=24 guifg=white

"""""""""""""""""""""""""""""""""""""""""""""}}}
" => Files, Backups, Undo {{{
"""""""""""""""""""""""""""""""""""""""""""""
" Use Unix as the standard file type
set ffs=unix,dos,mac

" Auto change current working directory
set autochdir

" Turn off backups
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""}}}
" => Tab (key) Related {{{
"""""""""""""""""""""""""""""""""""""""""""""
" Set tab width: 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Use spaces instead of tabs
set expandtab

" Try to be smart about tabs
set smarttab

" Auto indent
set autoindent

" Smart indent
set smartindent

" Wrap lines
set wrap

" Wrap lines at convenient points
set linebreak

"""""""""""""""""""""""""""""""""""""""""""""}}}
" => Plugins {{{    
"""""""""""""""""""""""""""""""""""""""""""""
" Vim-Airline plugin {{{
" Vim-Airline Settings {{{
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#enabled=0
let g:airline_mode_map = {
            \ '__' : '-',
            \ 'n'  : 'N',
            \ 'i'  : 'I',
            \ 'R'  : 'R',
            \ 'v'  : 'V',
            \ 'V'  : 'V-L',
            \ 'c'  : 'C',
            \ '': 'V-B',
            \ 's'  : 'S',
            \ 'S'  : 'S-L',
            \ '': 'S-B',
            \ 't'  : 'T',
            \ }
" Vim-Airline Theme
let g:airline_theme='wombat'
"}}}    
" Vi    m-Airline Tabline {{{
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod = ':t'
"}}}
" Vim-Airline Statusline {{{
let g:airline_section_c = '%h%.30{getcwd()}'
let g:airline_section_x = '%y%r[%l|%c]'
let g:airline_section_y = '%{strftime("%D")}'
let g:airline_section_z = '%{strftime("%I:%M %P")}'
"}}}}}}
" NeoComplete Plugin {{{
" Use autoComplpop?
let g:acp_enableAtStartup = 1
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <cr>: close popup and save indent.
inoremap <silent> <cr> <C-r>=<SID>my_cr_function()<cr>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<cr>"
  " For no inserting <cr> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<cr>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    "}}}
" Unite Plugin {{{  
" Unite Settings {{{
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --column'
    let g:unite_source_grep_recursive_opt = ''
endif
call unite#custom#profile('default', 'context', {'start_insert': 1, 'winheight': 10, 'direction': 'botright'})
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  setlocal noswapfile undolevels=-1
  imap <buffer> <esc> <Plug>(unite_exit)
  imap <buffer> -- <Plug>(unite_exit)
endfunction
"}}}
" Unite File search {{{
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
"}}}
" Unite Yank history {{{
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_limit = 20
"}}}
" Unite Keybinds {{{
" Search files recursively
nnoremap - :<C-u>UniteWithBufferDir -start-insert -toggle -auto-resize -wipe file_rec<cr>
" Search buffers
nnoremap <leader>b :<C-u>Unite -toggle -auto-resize -wipe buffer<cr>
" Search in files for pattern
nnoremap <leader>f :<C-u>Unite -toggle -wipe grep:.<cr>
" Search files in project path
nnoremap <leader>g :<C-u>UniteWithProjectDir -start-insert -toggle -auto-resize -wipe file_rec<cr>
" Search previous yanks
nnoremap <leader>y :<C-u>Unite -toggle history/yank<cr>
"}}}}}}
" Gundo Plugin {{{
" Gundo Settings {{{
let g:gundo_close_on_revert = 1
let g:gundo_width = 40
let g:gundo_preview_height = 30
"}}}
" Gundo Keybinds {{{
nnoremap <F5> :GundoToggle<cr>
"}}}}}}
" NERDTree plugin {{{
map <C-n> :NERDTreeToggle<cr>
"}}}

"""""""""""""""""""""""""""""""""""""""""""""}}}
" => Functions {{{
"""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing spaces on save (python scripts) {{{
function! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunction
autocmd BufWrite *.py :call DeleteTrailingWS()
""""""""""""""""""}}}
" Hex Editor {{{
""""""""""""""""""
" Hex editor key bindings
nnoremap <leader>h :Hexmode<cr>
vnoremap <leader>h :<C-U>Hexmode<cr>

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        silent :e " this will reload the file without trickeries 
                  "(DOS line endings will be shown entirely )
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        silent %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        silent %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction

" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
  " vim -b : edit binary using xxd-format!
  augroup Binary
    au!

    " set binary option for all binary files before reading them
    au BufReadPre *.bin,*.hex setlocal binary

    " if on a fresh read the buffer variable is already set, it's wrong
    au BufReadPost *
          \ if exists('b:editHex') && b:editHex |
          \   let b:editHex = 0 |
          \ endif

    " convert to hex on startup for binary files automatically
    au BufReadPost *
          \ if &binary | Hexmode | endif

    " When the text is freed, the next time the buffer is made active it will
    " re-read the text and thus not match the correct mode, we will need to
    " convert it again if the buffer is again loaded.
    au BufUnload *
          \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
          \   call setbufvar(expand("<afile>"), 'editHex', 0) |
          \ endif

    " before writing a file when editing in hex mode, convert back to non-hex
    au BufWritePre *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd -r" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif

    " after writing a binary file, if we're in hex mode, restore hex mode
    au BufWritePost *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd" |
          \  exe "set nomod" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif
  augroup END
endif "}}}

"""""""""""""""""""""""""""""""""""""""""""""
"}}} vim:foldmethod=marker:foldlevel=0
