" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif
set nocompatible
filetype off

" Auto-downloading of plugins
" ===========================

" Download NeoBundle if it isn't available
let isNeoBundleAvailable=0
let neobundle_indicator=expand('~/.vim/bundle/NeoBundle.lock')
if !filereadable(neobundle_indicator)
  echo "Installing NeoBundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  let isNeoBundleAvailable=1
endif

" Required for neobundle
set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/'))

" Initialize NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Initialize other plugins
NeoBundle 'Syntastic'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'
NeoBundle 'Valloric/YouCompleteMe', {
\ 'build' : {
\     'mac' : './install.sh --clang-completer',
\     'unix' : './install.sh --clang-completer',
\     'windows' : './install.sh --clang-completer',
\     'cygwin' : './install.sh --clang-completer'
\    }
\ }
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Quramy/tsuquyomi'

" TODO: Plugins go here

call neobundle#end()

if isNeoBundleAvailable == 1
  echo "Installing Bundles and Plugins"
  echo "! FIRST TIME WILL TAKE A WHILE"
  echo "------------------------------"
  NeoBundleInstall
endif

" See if anything has been changed since Vim was last run
NeoBundleCheck

" Vim Plugin Configuration
" ============

" Solarized color scheme
" ----------------------
colorscheme solarized
set background=dark
let g:solarized_visibility = "low"
set t_Co=16

" Syntastic
" ---------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_error_symbol = "⚠"
let g:syntastic_warning_symbol = ">"

" Vim-Airline
" -----------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
"let g:airline_enable_hunks = 0
set laststatus=2

" YouCompleteMe
" -------------
" No configuration!

" SCSS Syntax
" -----------
" No configuration!

" IndentLine
" ----------
let g:indentLine_char = '⦙'

" Native Vim Settings
" ===================

" This and that
set encoding=utf8
set ttyfast
set number
set ruler
set ffs=unix
set spell
set lazyredraw
set backspace=eol,start,indent
set magic
set joinspaces
syntax on

" History
set history=1000
set undolevels=1000

" Mouse interaction
set mouse=a
set mousemodel=popup_setpos
set selectmode=mouse

" Idnentation
set autoindent
set paste
set expandtab
set shiftwidth=2
set tabstop=2
filetype plugin indent on
set smarttab
set list
set listchars=tab:>.,extends:⤾,precedes:⤿,nbsp:.

" Line width and wrapping
set wrap
set textwidth=0
set wrapmargin=0
set linebreak
"match ErrorMsg '\%>80v.\+'

" Strip trailing space whenever buffer is saved
if !exists("*StripTrailingWhitespace")
  function StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
      normal mz
      normal Hmy
      %s/\s\+$//e
      normal 'yz<CR>
      normal `z
    endif
  endfunction
endif
autocmd FileWritePre    * :call StripTrailingWhitespace()
autocmd FileAppendPre   * :call StripTrailingWhitespace()
autocmd FilterWritePre  * :call StripTrailingWhitespace()
autocmd BufWritePre     * :call StripTrailingWhitespace()

" Wild menu
set wildmenu
set wildmode=longest:list,full

" Omit swap files
set nobackup
set noswapfile

" Search
set incsearch
set ignorecase
set smartcase
set hlsearch

" Matching ([{ }])
set showmatch
set mat=2
