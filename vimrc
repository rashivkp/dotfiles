" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')


" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'editorconfig/editorconfig-vim'
Plug 'jeetsukumaran/vim-pythonsense' "python movements
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'Yggdroot/indentLine' "display the indention levels with thin vertical lines 
Plug 'majutsushi/tagbar' "easy way to browse the tags of the current file
Plug 'w0rp/ale' "asynchronous lint engine
Plug 'tpope/vim-fugitive' "git wrapper
Plug 'airblade/vim-gitgutter' "shows a git diff in the gutter
Plug 'altercation/vim-colors-solarized'
Plug 'mattn/emmet-vim' "provides support for expanding abbreviations
Plug 'tpope/vim-sensible' "defaults everyone can agree on
Plug 'scrooloose/nerdcommenter' "Comment functions 
Plug 'tmhedberg/SimpylFold' "simple, correct folding for Python
Plug 'itchyny/lightline.vim' "light and configurable statusline
Plug 'mileszs/ack.vim' "search tool from vim
Plug 'Shougo/denite.nvim' "like a fuzzy finder
Plug 'sheerun/vim-polyglot' "collection of language packs

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

if has('nvim')
	" ncm2 completion framework configurations
	Plug 'ncm2/ncm2'
	Plug 'roxma/nvim-yarp'

	" enable ncm2 for all buffers
	autocmd BufEnter * call ncm2#enable_for_buffer()
	set completeopt=noinsert,menuone,noselect
	" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
	" found' messages
	set shortmess+=c

	" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
	inoremap <c-c> <ESC>

	" When the <Enter> key is pressed while the popup menu is visible, it only
	" hides the menu. Use this mapping to close the menu and also start a new
	" line.
	inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

	" Use <TAB> to select the popup menu:
	inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
	inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

	" wrap existing omnifunc
	" Note that omnifunc does not run in background and may probably block the
	" editor. If you don't want to be blocked by omnifunc too often, you could
	" add 180ms delay before the omni wrapper:
	"  'on_complete': ['ncm2#on_complete#delay', 180,
	"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
	au User Ncm2Plugin call ncm2#register_source({
					\ 'name' : 'css',
					\ 'priority': 9,
					\ 'subscope_enable': 1,
					\ 'scope': ['css','scss'],
					\ 'mark': 'css',
					\ 'word_pattern': '[\w\-]+',
					\ 'complete_pattern': ':\s*',
					\ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
					\ })


	" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
	Plug 'ncm2/ncm2-bufword'
	Plug 'ncm2/ncm2-path'
	Plug 'ncm2/ncm2-jedi'
endif

Plug 'embear/vim-localvimrc'  " local vimrc files

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
