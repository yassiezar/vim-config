" Set compatibility with NeoVim
function! DoRemote(arg)
	UpdateRemotePlugins
endfunction

set nocompatible              " be iMproved, required
filetype off                  " required

" avoid issues on some plugins if we use some shell other than bash
set shell=/bin/sh

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" Hosted on GitHub
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'lervag/vimtex'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'

" Theme
Bundle 'tomasr/molokai'
syntax enable
colorscheme molokai

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
filetype on
autocmd Filetype html setlocal ts=2 sw=2 expandtab

set ttyfast
set lazyredraw
set backspace=2
set spell
set spell spelllang=en_gb
set encoding=utf-8

" NERDTree Settings

" Auto open NERDTree
autocmd vimenter * NERDTree | wincmd p
" Close NERDTree when only NERDTree window is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_ignore_files = ['^/usr/', '*node_modules*', '*vendor*','*build*', '*LOCAL*', '*BASE', '*REMOTE*']
let g:syntastic_quiet_messages = { "level": "[]", "file": ['*_LOCAL_*', '*_BASE_*', '*_REMOTE_*']  }

" Airline settings
let g:airline_powerline_fonts = 1

" " Use 256 colours (Use this setting only if your terminal supports 256
" colours)
set t_Co=256

filetype plugin on
let mapleader = ","

" YouCompleteMe Settings
let g:ycm_add_preview_to_completeopt = 1

" Use Relative line numbers
" Also configure wrapping
set number
set relativenumber
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
command! -nargs=* Wrap set wrap linebreak nolist

" Activate Spell Checking and set line wrapping
set spell spelllang=en_gb
set wrap
set linebreak
set nolist

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i

" Copy/Pasting auto-indent turn off and allow copy/pasting between vim
" sessions
set pastetoggle=<F2>
set clipboard=unnamed

" Vimtex settings
let g:vimtex_latexmk_enabled = 0
let g:tex_flavor='latex'
filetype indent on
au FileType tex setlocal nocursorline

" Highlight current line
set cursorline
