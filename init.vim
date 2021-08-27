" Set compatibility with NeoVim
function! DoRemote(arg)
	UpdateRemotePlugins
endfunction

set nocompatible              " be iMproved, required
filetype off                  " required

" avoid issues on some plugins if we use some shell other than bash
set shell=/bin/sh

call plug#begin('~/.vim/plugged')

" Plugins
Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe', {'commit': '858d4f3759aca9bf0f94290feda402a6fb928f9d', 'do': 'python3 install.py --rust-completer --java-completer --clang-completer'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vhdirk/vim-cmake', {'for': 'cpp'}
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'
Plug '/home/jaycee/src/github.com/fzf/bin/fzf'
Plug 'junegunn/fzf.vim'

" Theme
Plug 'tomasr/molokai'
Plug 'fcevado/molokai_dark'
syntax enable
colorscheme molokai

call plug#end()
filetype plugin indent on    " required

filetype on
autocmd Filetype html setlocal ts=2 sw=2 expandtab

" Generic settings
set ttyfast
set lazyredraw
set backspace=2
set encoding=utf-8
"
" " Use 256 colours (Use this setting only if your terminal supports 256
" colours)
set t_Co=256

filetype plugin on
let mapleader = ","
" Copy/Pasting auto-indent turn off and allow copy/pasting between vim
" sessions
set pastetoggle=<F2>
set clipboard+=unnamed

" Highlight current line
set cursorline

" Custom mapping
" Close buffer
nnoremap <leader>q :bp<cr>:bd #<cr>
"
" Auto-close brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Enable copy-paste to and from clipboard
noremap <leader>y "*y
noremap <leader>p "*p
noremap <leader>Y "+y
noremap <leader>P "+p

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree Settings

" Auto open NERDTree
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
" Close nerdtree and qucikfix if closing a file
function! CheckLeftBuffers()
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if getbufvar(winbufnr(i), '&buftype') == 'help' ||
	  \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
	  \ exists('t:NERDTreeBufName') &&
	  \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
	  \ bufname(winbufnr(i)) == '__Tag_List__'
	let i += 1
      else
	break
      endif
    endwhile
    if i == winnr('$') + 1
      qall
    endif
    unlet i
  endif
endfunction
autocmd BufEnter * call CheckLeftBuffers()

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

" YouCompleteMe Settings
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 5

" Use Relative line numbers
" Also configure wrapping
set number
set relativenumber
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
command! -nargs=* Wrap set wrap linebreak nolist

" Activate Spell Checking and set line wrapping
set spell
set spell spelllang=en_gb
set wrap
set linebreak
set nolist

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i

" Vimtex settings
let g:vimtex_latexmk_enabled = 0
let g:tex_flavor='latex'
filetype indent on
au FileType tex setlocal nocursorline

" Settings for ASyncRun
" F7 compile project
" F8 run project
" F10 toggle quickfix
" set the quickfix window 6 lines height.
let g:asyncrun_open = 12

" ring the bell to notify you job finished
let g:asyncrun_bell = 1

" F10 to toggle quickfix window
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" Settings to find root of project and compile with CMake or Make
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
