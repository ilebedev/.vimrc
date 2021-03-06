Requirements
============
For this to work, the following must exist and be in good order on your machine:
* `vim`, obviously.
* `git`
* `cmake`
* `python-dev`

**NOTE**: If you use `tmux`, you may find it useful to alias `tmux` to `"TERM=xterm-256color /usr/bin/tmux"` by adding the following line to your `~/.bashrc`:

```
alias tmux="TERM=xterm-256color /usr/bin/tmux"
```

.vimrc
======

NOTE: You **must** have `git` installed for this to work.

This is the `.vimrc` file I use across all my machines. The file conveniently **auto-installs the plugin manager and all plugins**, and requires no user interaction to initialize on a new machine. My Vim looks like the screenshot below and works well over bare SSH. It works even better with `tmux` (the modern incarnation of `screen`, a persistent terminal session with some nifty UI features). I provide my `tmux` configuration file also.

This is my [.vimrc file](https://github.com/ilebedev/.vimrc/blob/master/.vimrc)

This is my [.tmux.conf file](https://github.com/ilebedev/.vimrc/blob/master/.tmux.conf). Make sure your TMUX environment shows `$TERM` as set to `screen-256color-bce`. You will have many issues with color in TMUX without this.

![Alt text](screenshots/vim.png "Screenshot")

#Auto-downloading of plugins
===========================

Installing a plugin manager manually is exactly as inconvenient as installing plugins, so I automate the process by adding a piece of script that will download and initialize the [`NeoBundle`](https://github.com/Shougo/neobundle.vim) plugin manager if it appears to not already be installed.

First, the prerequisites for our plugin manager:

```
set nocompatible
filetype off
```

Now onto the meat of the problem: at launch, Vim checks if the vile `~/.vim/bundle/NeoBundle.lock` exists, and if not, installs `NeoBundle` from its github repository:

```
let isNeoBundleAvailable=0
let neobundle_indicator=expand('~/.vim/bundle/NeoBundle.lock')
if !filereadable(neobundle_indicator)
  echo "Installing NeoBundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  let isNeoBundleAvailable=1
endif
```

After this is all done, we assume that `NeoBundle` is installed. We can now initialize it:

```
set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
```

Finally, we give a set of bundles and plugins:

```
" TODO: Plugins go here
```

And the plugins specified above are installed/loaded:

```
if isNeoBundleAvailable == 1
  echo "Installing Bundles and Plugins"
 echo "! FIRST TIME WILL TAKE A WHILE"
 echo "------------------------------"
 NeoBundleInstall
 endif
 
 " See if anything has been changed since Vim was last run
 NeoBundleCheck
endif
```

#Vim Plugins
============

I set plugin settings first to make sure that any Vim settings I change later are not blown away by an ambitious plugin trying to configure things as it sees fit.

##Solarized color scheme
------------------------

I use Ethan Schoonover's excellent [Solarized](http://ethanschoonover.com/solarized) color scheme, which provides good contrast and accessible colors for both dark and light backgrounds, uses a sensible color pallete, is easy on the eyes, and works with both light and heavy fonts. To load the [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized) plugin, add the following in the `" TODO: Plugins go here` section described [above](.#auto-downloading-of-plugins).

```
NeoBundle 'altercation/vim-colors-solarized'
```

If you use Vim in a GUI, you can skip this step.
If, however, you use Vim in a terminal (I do!), you need to consider how your terminal interprets colors.
This gets very complicated indeed when multiple nested terminals try doing conflicting clever things with your colors (Vim in bash in TMUX, for example). Make sure your termina's 16-color palette matches the Solarized colors, these are what Vim will be using to display things. Your favorite terminal may have a preset available for download [here](https://github.com/altercation/solarized), but mine (Gnome Terminal) did not. I set my terminal colors to manually (the values are [here](http://ethanschoonover.com/solarized/vim-colors-solarized#the-values), and the [.Xresources file](https://github.com/altercation/solarized/blob/master/xresources/solarized) is particularly helpful when copy&pasting color values into your terminal's config GUI.).

Finally, select the new color scheme, and ask for low-contrast formatting characters (like indent lines):
```
colorscheme solarized
set background=dark
let g:solarized_visibility = "low"
set t_Co=16
```

To use the light `solarized` scheme, replce the last command with `set background=light`. This can also be done by typing the command in the editor, and is very useful when working in various lighting conditions.

**NOTE:** The plugin relies on your terminal having appropriate color support, unless you are running the GUI variant of Vim. Set your termina's 16-color palete to use Solarized colors, as described above.

##Syntastic
-----------

The [Syntastic](https://github.com/scrooloose/syntastic) plugin uses native syntax checkers (`lint`-like tooks) to give syntax error indicators for a large number of languages. This plugin requires some features not present in all installations of Vim, but Vim version 7 or later with the "normal", "big", or "huge" feature set should not have any problems. To install the plugin, add the following in the `" TODO: Plugins go here` section described [above](.#auto-downloading-of-plugins).

```
NeoBundle 'Syntastic'
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

[Airline](https://github.com/bling/vim-airline) is a cute plugin that helps maintain a neat (and somwhat flashy) status line. Unfortunatley, Airline relies on some special glyphs from the [Powerline](https://github.com/powerline/powerline) project for its good looks, and may require system fonts be [patched](https://powerline.readthedocs.org/en/master/installation.html#patched-fonts). Many pre-patched fonts can be found [here](https://github.com/powerline/fonts). I personally use 13 point `Ubuntu Mono derivative Powerline` font.

To install Airline, add the following in the `" TODO: Plugins go here` section described [above](.#auto-downloading-of-plugins).

```
NeoBundle 'bling/vim-airline'
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

Val Markovic's [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) fuzzy-search code completion engine aggregades data from several auto-completion to be an all-around helpful addition to Vim. To install the plugin, add the following in the `" TODO: Plugins go here` section described [above](.#auto-downloading-of-plugins).

```
NeoBundle 'Valloric/YouCompleteMe', {
\ 'build' : {
\     'mac' : './install.sh --clang-completer',
\     'unix' : './install.sh --clang-completer',
\     'windows' : './install.sh --clang-completer',
\     'cygwin' : './install.sh --clang-completer'
\    }
\ }
```

You may consult instructions [here](https://github.com/Valloric/YouCompleteMe#installation) for additional arguments to the build script. TLDR: using the build script above works.

##Interactive Command Execution in VIM
-------------
A prerequisite for the typescript plugin below, consult [here](https://github.com/Shougo/vimproc.vim) for details.
To install the plugin, add the following in the `" TODO: Plugins go here` section described [above](.#auto-downloading-of-plugins).

```
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
```

##Language-Specific Plugins
-------------

To improve on Vim's handling of languages I use that it does not handle well out of the box, I use additional plugins.

To install the plugins, add the relevant commands below to the `" TODO: Plugins go here` section described [above](.#auto-downloading-of-plugins).

Language | Command | Configuration
---------|---------|--------------
SCSS (Sassy CSS) | [`NeoBundle 'cakebaker/scss-syntax.vim'`](https://github.com/cakebaker/scss-syntax.vim) | (none)
TypeScript | [`NeoBundle 'Quramy/tsuquyomi'`](https://github.com/Quramy/tsuquyomi) | (none)
Go | [`NeoBundle 'fatih/vim-go'`](https://github.com/fatih/vim-go) | (none)


##IndentLine
------------

One feature Vim surprisingly does not build in is indent indicators. These offer visual cues to match indent levels in code, and are common in GUI editors. Yggdroot's [IndentLine](https://github.com/Yggdroot/indentLine) does exactly what it's supposed to - replace whitespace at ident intervals with a configurable character. To install the plugin, add the following in the `" TODO: Plugins go here` section described [above](.#auto-downloading-of-plugins).

```
NeoBundle 'Yggdroot/indentLine'
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
`set backspace=eol,start,indent` | Make backspace act as backspace should.
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

Indentation makes code cleaner. I use spaces instead of tabs, and use 2 spaces per tab for compact-looking code.

Command in `.vimrc` | What the command does
------------- | -------------
`set autoindent` | Attempt to ident automatically.
`set paste` | Fix indentation of code pasted into Vim.
`set expandtab` | Replace tabs with spaces.
`set shiftwidth=2` | Tabs are 2 spaces.
`set tabstop=2` | Tabs are aligned to 2-space intervals.
`filetype plugin indent on` | Use filetypes for indentation. Also used for highlighting, etc.
`set smarttab` | Try to be [smart](http://vim.wikia.com/wiki/Indent_with_tabs,_align_with_spaces) about tabulation. 
`set list` | display whitespace visually
`set listchars=tab:>.,extends:⤾,precedes:⤿,nbsp:.` | Display tabs as ">..." for tabwidth 4

Line width and wrapping at terminal boundaries; warn when lines are longer than 80 characters

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
set wildmode=longest:list,full
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

Add some key mappings to make copy and selection shortcuts more in line with other editors to avoid shortcut pains when switching back and forth.

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

Ctrl-Z, Ctrl-Y : Undo, Redo. Accidental use of Ctrl-Z if it isn't remapped is very dangerous (insta-quit!), and not uncommon if you mapped Ctrl-C/X/V to clipboard operations.
These may or may not be a little wonky in some terminals.
```
noremap <C-Z> u
inoremap <C-Z> <C-O>u
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>
```
