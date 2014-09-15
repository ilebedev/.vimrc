.vimrc
======

This is the vimrc file I use across all my machines. The file conveniently auto-installs plugins, and requires no user interaction to (with the exception of the CompleteMe plugin, which requires a compiled component). My Vim looks like this (TODO: screenshot), and works well over bare SSH.

Auto-downloading of plugins
===========================

This is essentially Erik Zaadi's script (which can be found <a href="http://erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/">here</a>).

Vim Settings
============

Specify a unicode character encoding
set encoding=utf8

Send more characters to the terminal for fast redraw
set ttyfast

Extend undo and history to avoid nasy surprises when undoing a lot of work.
set history=1000
set undolevels=1000

It's hard to work without line and column numbers!
set number
set ruler

Enable mouse interaction. This is fantastically helpful for selection, scrolling, and switching tabs if you like using the mouse sometimes.
set mouse=a
set selectmode=mouse

Rely on version control for backups, and avoid creating swap files
set nobackup
set noswapfile

TODO: auto-refreshing of edited files is currently a not very good. I should improve on that.

Syntax highlighting all the things!
syntax on

Idnentation makes code cleaner. I use spaces instead of tabs, and use 2 spaces per tab for compact-looking code.
set autoidndent
set paste
set expandtab

TODO: document the rest

Discourage lines longer than 80 characters
==========================================

Long lines will be highlighted red. Keeping lines short is generally a good habit.
match ErrorMsg '\%>80v.\+'

Auto-remove trailing whitespace when saving
===========================================

Todo: show and explain a script that removes trailing white space
TODO: reference where this script came from.

Solarized color scheme
======================
TODO: document this!

Syntastic
=========

TODO: I ought to explain what this is and how to use it here..

Vim-Airline
===========

Airline is a neat plugin that helps maintain a neat status line. Visit the plugin's GitHub <a href="https://github.com/bling/vim-airline">here</a>.

Airline relies on some special glyphs for its good looks, and may require system fonts be patched.
TODO: explain how this is done

TODO: show status line code

Vim-Signify
===========

TODO: I ought to explain what this is and how to use it here..
