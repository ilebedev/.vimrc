.vimrc
======

This is the `.vimrc` file I use across all my machines. The file conveniently **auto-installs the plugin manager and all plugins**, and requires no user interaction to initialize on a new machine (with the exception of the CompleteMe plugin, which requires a compiled component). My Vim looks like the screenshot below and works well over bare SSH. It works even better with `tnux` (the modern incarnation of `screen`, a persistent terminal session with some nifty UI features). I provide my `tmux` and `bash` configuration files also.

![Alt text](http://full/path/to/img.jpg "Screenshot")

#Auto-downloading of plugins
===========================

Installing a plugin manager manually is exactly as inconvenient as installing plugins, so I automate the process by using what is essentially [Erik Zaadi's script] (http://erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/) to auto-install the [`Vundle`](https://github.com/gmarik/Vundle.vim) plugin manager if it appears to not already be installed.

First, the prerequisites for our plugin manager:

```
set nocompatible
filetype off
```

Now onto the meat of the problem: at launch, Vim checks if the vile `~/.vim/bundle/Vundle.vim/README.md` exists, and if not, installs `Vundle` from its github repository:

```
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  let iCanHazVundle=0
endif
```

After this is all done, we can safely assume that `Vundle` is installed (as long as the check for `vundle_readme` above is not fooled). We can now initialize it:

```
set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
call vundle#rc()
Plugin 'gmarik/Vundle.vim'

" TODO: Plugins go here
```

Finally, we give a set of bundles and plugins to be installed, and load them:

```
if iCanHazVundle == 0
  echo "Installing Bundles and Plugins"
  echo ""
  :BundleInstall
endif
```

Here is a screenshot of Vim loading plugins at startup. Nifty!

![Alt text](http://full/path/to/img.jpg "Screenshot")

#Vim Plugins
============

I set plugin settings first to make sure that any Vim settings I change later are not blown away by an ambitious plugin trying to configure things as it sees fit.

##Solarized color scheme
------------------------

![Alt text](http://full/path/to/img.jpg "Screenshot")

I use Ethan Schoonover's excellent [Solarized](http://ethanschoonover.com/solarized) color scheme, which provides good contrast and accessible colors for both dark and light backgrounds, uses a sensible color pallete, is easy on the eyes, and works with both light and heavy fonts. To load the [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized) plugin, add the following in the `" TODO: Plugins go here` section described [above](.#auto-downloading-of-plugins).

```
Bundle 'altercation/vim-colors-solarized'
```

Now, to actually use this color scheme, we need to ensure 256-color output is enabled, and select the `solarized` color scheme:

```
set t_Co=256 " Set 256 color terminal (else colors may be very off)
colorscheme solarized
set background=dark
```

To use the light `solarized` scheme, replce the last command with `set background=light`. This can also be done by typing the command in the editor, and is very useful when working in various lighting conditions.

**NOTE:** The plugin relies on your terminal having appropriate color support. I add my .bashrc file 
It is worth noting that I set up my terminal emulator to use the `solarized` color scheme as well (see instructions on the [Solarized web site](http://ethanschoonover.com/solarized)).

##Syntastic
-----------

![Alt text](http://full/path/to/img.jpg "Screenshot")

The [Syntastic](https://github.com/scrooloose/syntastic) plugin uses native syntax checkers (`lint`-like tooks) to give syntax error indicators for a large number of languages. This plugin requires some features not present in all installations of Vim, but Vim version 7 or later with the "normal", "big", or "huge" feature set should not have any problems. To install the plugin, add the following in the `" TODO: Plugins go here` section described [above](.#auto-downloading-of-plugins).

```
Bundle 'Syntastic'
```

I customize the plugin somewhat: I do not use the location list (list of all errors and warnings in the file), and change the characters used to tag suspicious lines in your code:

Command in `.vimrc` | What the command does
------------- | -------------
`let g:syntastic_always_populate_loc_list = 1` | auto-load errors into the location list.
`let g:syntastic_auto_loc_list = 0` | Do not open the loc list automatically.
`let g:syntastic_check_on_open = 1` | Run checker and look for errors when the file is opened (only runs on save by default).
`let g:syntastic_check_on_wq = 1` | Run the checker whenever the file is saved.
`let g:syntastic_quiet_messages = { "type": "style" }` | Disable style warnings because we probably have our own style guide!
`let g:syntastic_error_symbol = "⚠"` | Change the symbol for lines with errors. Fun fact: you can use unicode!
`let g:syntastic_warning_symbol = ">"` | Change the symbol for lines with errors. Fun fact: you can use unicode!

##Vim-Airline
-------------

![Alt text](http://full/path/to/img.jpg "Screenshot")

[Airline](https://github.com/bling/vim-airline) is a cute plugin that helps maintain a neat (and somwhat flashy) status line. Unfortunatley, Airline relies on some special glyphs from the [Powerline](https://github.com/powerline/powerline) project for its good looks, and may require system fonts be [patched](https://powerline.readthedocs.org/en/master/installation.html#patched-fonts). Many pre-patched fonts can be found [here](https://github.com/powerline/fonts). I personally use 13 point `Ubuntu Mono derivative Powerline` font.

To install Airline, add the following in the `" TODO: Plugins go here` section described [above](.#auto-downloading-of-plugins).

```
Bundle 'bling/vim-airline'
```

Configure Airline (See [here](https://github.com/bling/vim-airline/blob/master/doc/airline.txt) for more config commands):

Command in `.vimrc` | What the command does
------------- | -------------
`let g:airline#extensions#tabline#enabled = 1`<br>`let g:airline#extensions#tabline#fnamemod = ':t'` | show a list of buffers at the top, but show only the filename (not the whole path).
`let g:airline_powerline_fonts = 1` | Turn on pretty-looking Powerline font glyphs.
`"let g:airline_enable_hunks = 0` | Disable hunks, whatever they are, if they seem to be causing problems
`set laststatus=2` | Use a fancy 2-row status line with information on top row, and command entry on the bottom.

##YouCompleteMe
---------------

![Alt text](http://full/path/to/img.jpg "Screenshot")

**Note:** Although there isn't any configuration needed to make this plugin shine, installing it involves compiling things. When using Vim over SSH on less-than-capable machines, it makes sense to skip installing this plugin.

Val Markovic's [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) fuzzy-search code completion engine aggregades data from several auto-completion to be an all-around helpful addition to Vim. To install the plugin, add the following in the `" TODO: Plugins go here` section described [above](.#auto-downloading-of-plugins).

```
Plugin 'Valloric/YouCompleteMe'
```

We aren't done here yet! Follow the steps [here](https://github.com/Valloric/YouCompleteMe#installation) to satisfy the prerequisites and run the installation script.

##SCSS Syntax
-------------

![Alt text](http://full/path/to/img.jpg "Screenshot")

To improve on Vim's handling of Sassy CSS, I use Daniel Hofstetter's [scss-syntax](https://github.com/cakebaker/scss-syntax.vim) plugin. There is no configuration. To install the plugin, add the following in the `" TODO: Plugins go here` section described [above](.#auto-downloading-of-plugins).

```
Plugin 'cakebaker/scss-syntax.vim'
```

##IndentLine
------------

![Alt text](http://full/path/to/img.jpg "Screenshot")

One feature Vim surprisingly does not build in is indent indicators. These offer visual cues to match indent levels in code, and are common in GUI editors. Yggdroot's [IndentLine](https://github.com/Yggdroot/indentLine) does exactly what it's supposed to - replace whitespace at ident intervals with a configurable character. To install the plugin, add the following in the `" TODO: Plugins go here` section described [above](.#auto-downloading-of-plugins).

```
Bundle 'Yggdroot/indentLine'
```

There is not much configuration to be done. I change the indent character to reduce contrast, making it a bit more subtle:

```
let g:indentLine_char = '︙'
```

#Native Vim Settings
====================

I mess with Vim's defaults somewhat to set up a more productive environment.

Some general settings:

Command in `.vimrc` | What the command does
------------- | -------------
`set encoding=utf8` | Use UTF-8 for unicode.
`set ttyfast` | Speeds up redraw by sending characters quickly.
`set number`<br>`set ruler` | Show line numbers everywhere, and line/col counter in the status line.
`set ffs=unix` | UNIX line endings (\n).
`set spell` | Spell checker.
`set lazyredraw` | Don't redraw while executing macros for performance.
`set backspace=eos,start,indent` | Make backspace act as backspace should.
`set magic` | Turn [magic](http://vimdoc.sourceforge.net/htmldoc/pattern.html#/magic) regular expressions on.
`set joinspaces` | Put two spaces after periods.
`syntax on` | Turn on syntax highlighting.

Adjust history: Keep a long history of commands and a long undo buffer.

```
set history=1000
set undolevels=1000
```

Enable [mouse interaction](http://vimdoc.sourceforge.net/htmldoc/options.html#'mouse'). This is fantastically helpful for selection, scrolling, and switching tabs if you like using the mouse sometimes.

Command in `.vimrc` | What the command does
------------- | -------------
`set mouse=a` | enable mouse input in all editing modes
`set mousemodel=popup_setpos` | Allows the terminal to pop up a menu on rightclick. See [here](http://vimdoc.sourceforge.net/htmldoc/options.html#'mousemodel').
`set selectmode=mouse` | enable mouse input! This does many nice things, like allowing you to click around to move the cursor.

Idnentation makes code cleaner. I use spaces instead of tabs, and use 2 spaces per tab for compact-looking code.

Command in `.vimrc` | What the command does
------------- | -------------
`set autoidndent` | Attempt to ident automatically.
`set paste` | Fix identation of code pasted into Vim.
`set expandtab` | Replace tabs with spaces.
`set shiftwidth=2` | Tabs are 2 spaces.
`set tabstop=2` | Tabs are aligned to 2-space intervals.
`filetype plugin indent on` | Use filetypes for identation. Also used for highlighting, etc.
`set smarttab` | Try to be [smart](http://vim.wikia.com/wiki/Indent_with_tabs,_align_with_spaces) about tabulation. 
`set list` | display whitespace visually
`set listchars=tab:>.,extends:⤾,precedes:⤿,nbsp:.` | Display tabs as ">..." for tabwidth 4

Line width and wrapping at 80 characters

Command in `.vimrc` | What the command does
------------- | -------------
`set wrap` | Vim only warps text visually
`set textwidth=0` | Do not insert linebreaks.
`set wrapmargin=0` | Do not insert linebreaks.
`set linebreak` | Vim wraps only on " \t!@*-+;:,./?".
`match ErrorMsg '\%>80v.\+'` | Mark characters after line is longer than 80 characters.

Also strip trailing whitespace whenever the buffer is saved
```
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
```

Wild menu helps complete commands, find files based on wildcards, etc. It's fantastically productive.

```
set wildmenu
set wildmenu=list:longest,list:full
```

Rely on version control, so avoid creating swap files
```
set nobackup
set noswapfile
```

Configure how Vim searches: search like modern browsers search, and ignore case unless uppercase is used in the search term; highlight search results.
```
set incsearch
set ignorecase
set smartcase
set hlsearch
```

Show matching parens, brackets, and braces; Flash the matching pair for 2/10 seconds.
```
set showmatch
set mat=2
```

##Keyboard Shortcuts
--------------------

Add some key mappings to make copy and selection shortcuts more accessible

```
vnoremap <C-X> "+x
vnoremap <C-C> "+y
map <C-V> "+gP
cmap <C-V> <C-R>+
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
```

Use CTRL-Q to do what CTRL-V used to do; `noremap <C-Q> <C-V>`

CTRL-A is Select all
```
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG
```
