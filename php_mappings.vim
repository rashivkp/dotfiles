let g:phpactorInitialCwd = getcwd()

nnoremap <leader>d :PhpactorGotoDefinition<CR>
nnoremap <leader>i :PhpactorImportMissingClasses<CR>
nnoremap <leader>f :PhpactorTransform<CR>

vnoremap <leader>y :join <bar> <<<<<<< <bar> yank + <bar> u <CR>

