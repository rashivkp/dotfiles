" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')


" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'editorconfig/editorconfig-vim'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'Konfekt/FastFold'
Plug 'davidhalter/jedi-vim'
Plug 'Yggdroot/indentLine'
Plug 'majutsushi/tagbar'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdcommenter'
Plug 'tmhedberg/SimpylFold'
Plug 'itchyny/lightline.vim'
Plug 'mileszs/ack.vim'
Plug 'Shougo/denite.nvim'

" Initialize plugin system
call plug#end()

syntax on
filetype plugin indent on

"let g:solarized_termcolors=16|256
set background=light
colorscheme solarized

let Tlist_Use_Right_Window = 1
map <F7> Oimport ipdb; ipdb.set_trace()
nmap <F8> :TagbarToggle<CR>
set tags=./.git/tags;,.git/tags;./tags;

" help ale-navigation-commands
nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)

" Ale https://github.com/w0rp/ale

" FastFold
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

" Make sure you use single quotes


" Denite {{{
" Change file_rec command.
call denite#custom#var('file_rec', 'command',
      \ ['ag', '--follow', '--nocolor', '--nogroup', '--ignore=*.pyc', '-g', ''])

" Change mappings.
call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-t>',
      \ '<denite:do_action:tabopen>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-v>',
      \ '<denite:do_action:split>',
      \ 'noremap'
      \)

" Change sorters.
call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])
"call denite#custom#source('line', 'sorters', ['sorter/sublime'])
call denite#custom#source('line', 'matchers', ['matcher/fuzzy'])

" Change default prompt
call denite#custom#option('default', 'prompt', '➤ ')

 " change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
       \ [ '.git/', '.ropeproject/', '__pycache__/*', '*.pyc',
       \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/', '*.png', '*.jpg', '*.jpeg'])

nnoremap <C-p> :Denite file_rec<cr>
"nnoremap <space>s :Denite file_rec -default-action=split<cr>
"nnoremap <space>e :Denite file_rec -winheight=10 <cr>
"nnoremap <space>m :Denite file_mru -winheight=10 -vertical-preview -auto-preview <cr>
nnoremap <space>l :Denite line -auto-preview<cr>
" }}}

function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction

function! FzyCommandWithLines(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . strpart(output, 0, strlen(output)-1)
  endif
endfunction

nnoremap <leader>t :call FzyCommand("ag . --silent -l -g ''", ":tabe")<cr>
nnoremap <leader>e :call FzyCommand("ag . --silent -l -g ''", ":e")<cr>
nnoremap <leader>v :call FzyCommand("ag . --silent -l -g ''", ":vs")<cr>
nnoremap <leader>s :call FzyCommand("ag . --silent -l -g ''", ":sp")<cr>
nnoremap <leader>l :call FzyCommandWithLines("cat " . @%, "?")<cr>

