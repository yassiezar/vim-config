setlocal shiftwidth=2
setlocal softtabstop=2
setlocal noexpandtab

nnoremap <silent> <F6> :VimtexCompile <cr>
inoremap <silent> <F8> <ESC> :w <bar> :VimtexCompileSS <cr>
nnoremap <silent> <F8> :w <bar> :VimtexCompileSS <cr>
