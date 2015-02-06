" Auto-downloading of plugins
" ===========================
set nocompatible
filetype off

" Download Vundle if it isn't available
let isVundleAvailable=0
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  let isVundleAvailable=1
endif

" Initialize Vundle
set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
call vundle#rc()
Plugin 'gmarik/Vundle.vim'

Bundle 'Syntastic'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
Plugin 'Valloric/YouCompleteMe'
Plugin 'cakebaker/scss-syntax.vim'
Bundle 'Yggdroot/indentLine'

" TODO: Plugins go here

if isVundleAvailable == 1
  echo "Installing Bundles and Plugins"
  echo "------------------------------"
  :BundleInstall
endif


" Vim Plugins
" ============

" Solarized color scheme
" ----------------------
set t_Co=256 " Set 256 color terminal (else colors may be very off)
colorscheme solarized
set background=dark

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
let g:indentLine_char = '︙'

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
match ErrorMsg '\%>80v.\+'

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

" Keyboard Shortcuts
" ------------------

" Ctrl-C, Ctrl-X, Ctrl-V : Copy, Cut, Paste
vnoremap <C-X> "+x
vnoremap <C-C> "+y
map <C-V> "+gP
cmap <C-V> <C-R>+
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

" Use CTRL-Q to do what CTRL-V used to do;
noremap <C-Q> <C-V>

" Ctrl-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG
