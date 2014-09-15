"
" Vim Plugins
" ===========
"

" Vundle (Plugin manager)
set nocompatible
filetype off

" Automagically install Vundle and all bundles/plugins
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  let iCanHazVundle=0
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
call vundle#rc()
Plugin 'gmarik/Vundle.vim'

" PLUGINS:
" Additional plugins below
Bundle 'altercation/vim-colors-solarized'
Bundle 'Syntastic'
Bundle 'bling/vim-airline'
Bundle 'mhinz/vim-signify'
Bundle 'https://github.com/tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
" TODO: any additional plugins go here

if iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :BundleInstall
endif

filetype plugin indent on

"
" Plugin Configuration
" ====================
"

" Airline ( fancy status line )
" -----------------------------

" Enable list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show filename only
let g:airline#extensions#tabline#fnamemod = ':t'

" Nice-looking Powerline fonts
let g:airline_powerline_fonts = 1

" Disable hunks, whatever they are, as they seem to be causing problems
let g:airline_enable_hunks = 0

"
" Other VIM settings
" ==================
"

" utf8 default encoding
set encoding=utf8

" Send more characters for fast redraw
set ttyfast

" Levels of history
set history=1000
set undolevels=1000

" Line numbers
set number
set ruler

" Enable mouse input
set mouse=a
set selectmode=mouse

" Do not use swap files (rely on version control instead)
set nobackup
set noswapfile

" Auto-update buffer when file is changed externally
" NOTE: this is a little fucky
set autoread

" Syntax highlighting
syntax on

" Indentation
set autoindent
set paste " fix autoindent of pasted text
set expandtab " turn tabs to spaces
set shiftwidth=2 " tabs are 2 spaces
set tabstop=2
set smarttab
set list " show tab characters, visual whitespace
set listchars=tab:>.

" Line width
set textwidth=80
set wrap
set linebreak

" Line endings
set ffs=unix

" Color scheme
colorscheme solarized
set t_Co=256
set background=dark

" Spell checker
set spell

" Make backspace act normal
set backspace=eol,start,indent

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Two spaces after a period
set joinspaces

" Fancy pants status line
set laststatus=2

set statusline=%F                              " tail of the filename
set statusline+=\                              " whitespace
set statusline+=[%{strlen(&fenc)?&fenc:'none'},  " file encoding
set statusline+=%{&ff}]                        " file format
set statusline+=%h                             " help file flag
set statusline+=%m                             " modified flag
set statusline+=%r                             " read only flag
set statusline+=%y                             " filetype
set statusline+=%w                             " filetype
if exists('g:loaded_fugitive')
  set statusline+=%{fugitive#statusline()}
endif
set statusline+=%=                             " left/right separator
set statusline+=\ %#warningmsg#                " start warnings highlight group
set statusline+=%*                             " end highlight group
set statusline+=%c,                            " cursor column
set statusline+=%l/%L                          " cursor line/total lines
set statusline+=\ %P                           " percent through file

" Re-read the vimrc file when editing the vimrc file
au BufLeave $MYVIMRC :source $MYVIMRC

" Remove trailing whitespace on save
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

" Show characters past 80th column as errors
match ErrorMsg '\%>80v.\+'

