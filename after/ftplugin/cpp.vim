set expandtab
set shiftwidth=4
set softtabstop=4

nnoremap <silent> <F4> :AsyncRun -cwd=<root>/build cmake .. <cr>
nnoremap <silent> <F7> :AsyncRun -cwd=<root>/build make <cr>
nnoremap <silent> <F8> :AsyncRun -cwd=<root>/build -raw make run <cr>
