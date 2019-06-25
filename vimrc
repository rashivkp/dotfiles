" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')


" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'editorconfig/editorconfig-vim'
Plug 'jeetsukumaran/vim-pythonsense' 	"python movements
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'Yggdroot/indentLine'				"display the indention levels with thin vertical lines 
Plug 'majutsushi/tagbar' 				"easy way to browse the tags of the current file
Plug 'w0rp/ale'							"asynchronous lint engine
Plug 'tpope/vim-fugitive' 				"git wrapper
Plug 'airblade/vim-gitgutter'			"shows a git diff in the gutter
Plug 'altercation/vim-colors-solarized'
Plug 'mattn/emmet-vim'					"provides support for expanding abbreviations
Plug 'tpope/vim-sensible' 				"defaults everyone can agree on
Plug 'tpope/vim-commentary'				"Comment functions 
Plug 'itchyny/lightline.vim'			"light and configurable statusline
Plug 'mileszs/ack.vim'					"search tool from vim
Plug 'Shougo/denite.nvim' 				"like a fuzzy finder
Plug 'sheerun/vim-polyglot'				"collection of language packs
Plug 'davidhalter/jedi-vim' 			"autocomplet and usages, go-to assignments
Plug 'Konfekt/FastFold'					"faster folding
Plug 'zhimsel/vim-stay'					"stay at previously colsed position
Plug 'tmhedberg/SimpylFold'				"simple, correct folding for Python
Plug 'fatih/vim-go'						"Go development plugin

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
let mapleader=','

"let g:solarized_termcolors=16|256
set background=light
colorscheme solarized

let Tlist_Use_Right_Window = 1
map <F7> Oimport ipdb; ipdb.set_trace()
nmap <F8> :TagbarToggle<CR>
set tags=./.git/tags;,.git/tags;./tags;

" help ale-navigation-commands
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Ale https://github.com/w0rp/ale

" FastFold
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
"do not close folds automatically
set foldlevelstart=99

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

" function! FzyCommand(choice_command, vim_command)
"   try
"     let output = system(a:choice_command . " | fzy ")
"   catch /Vim:Interrupt/
"     " Swallow errors from ^C, allow redraw! below
"   endtry
"   redraw!
"   if v:shell_error == 0 && !empty(output)
"     exec a:vim_command . ' ' . output
"   endif
" endfunction

" function! FzyCommandWithLines(choice_command, vim_command)
"   try
"     let output = system(a:choice_command . " | fzy ")
"   catch /Vim:Interrupt/
"     " Swallow errors from ^C, allow redraw! below
"   endtry
"   redraw!
"   if v:shell_error == 0 && !empty(output)
"     exec a:vim_command . strpart(output, 0, strlen(output)-1)
"   endif
" endfunction

function! FzyCommand(choice_command, vim_command) abort
    let l:callback = {
                \ 'window_id': win_getid(),
                \ 'filename': tempname(),
                \  'vim_command':  a:vim_command
                \ }

    function! l:callback.on_exit(job_id, data, event) abort
        bdelete!
        call win_gotoid(self.window_id)
        if filereadable(self.filename)
            try
                let l:selected_filename = readfile(self.filename)[0]
                exec self.vim_command . l:selected_filename
            catch /E684/
            endtry
        endif
        call delete(self.filename)
    endfunction

    botright 10 new
    let l:term_command = a:choice_command . ' | fzy > ' .  l:callback.filename
    silent call termopen(l:term_command, l:callback)
    setlocal nonumber norelativenumber
    startinsert
endfunction


nnoremap <leader>t :call FzyCommand("ag . --silent -l -g ''", ":tabe")<cr>
nnoremap <leader>e :call FzyCommand("ag . --silent -l -g ''", ":e")<cr>
nnoremap <leader>v :call FzyCommand("ag . --silent -l -g ''", ":vs")<cr>
nnoremap <leader>s :call FzyCommand("ag . --silent -l -g ''", ":sp")<cr>
nnoremap <leader>l :call FzyCommandWithLines("cat " . @%, "?")<cr>


"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" Keep search matches in the middle of the window and pulse the line when moving
" to them.
nnoremap n nzzzv:call PulseCursorLine()<cr>
nnoremap N Nzzzv:call PulseCursorLine()<cr>

" Pulse cursor ------------------------------------------------------------------- {{{

function! PulseCursorLine()
    let current_window = winnr()

    windo set nocursorline
    execute current_window . 'wincmd w'

    setlocal cursorline

    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    hi CursorLine guibg=#2a2a2a
    redraw
    sleep 30m

    hi CursorLine guibg=#333333
    redraw
    sleep 30m

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 30m

    hi CursorLine guibg=#444444
    redraw
    sleep 30m

    hi CursorLine guibg=#4a4a4a
    redraw
    sleep 30m

    hi CursorLine guibg=#555555
    redraw
    sleep 30m

    execute 'hi ' . old_hi

    windo set cursorline
    execute current_window . 'wincmd w'
endfunction

" }}}

