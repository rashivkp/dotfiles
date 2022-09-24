" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')


" Multiple Plug commands can be written in a single line using | separators
Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'editorconfig/editorconfig-vim'
Plug 'jeetsukumaran/vim-pythonsense' 	"python movements
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'Yggdroot/indentLine'				"display the indention levels with thin vertical lines
Plug 'majutsushi/tagbar' 				"easy way to browse the tags of the current file
Plug 'dense-analysis/ale'				"asynchronous lint engine
Plug 'tpope/vim-fugitive' 				"git wrapper
Plug 'airblade/vim-gitgutter'			"shows a git diff in the gutter
Plug 'altercation/vim-colors-solarized'
Plug 'mattn/emmet-vim'					"provides support for expanding abbreviations
Plug 'tpope/vim-sensible' 				"defaults everyone can agree on
Plug 'tpope/vim-commentary'				"Comment functions
Plug 'itchyny/lightline.vim'			"light and configurable statusline
Plug 'mileszs/ack.vim'					"search tool from vim
Plug 'sheerun/vim-polyglot'				"collection of language packs
Plug 'davidhalter/jedi-vim' 			"autocomplet and usages, go-to assignments
Plug 'Konfekt/FastFold'					"faster folding
Plug 'tmhedberg/SimpylFold'				"simple, correct folding for Python
Plug 'fatih/vim-go'						"Go development plugin
Plug 'ludovicchabant/vim-gutentags'     "tags creation automatically
Plug 'stephpy/vim-php-cs-fixer'
Plug 'StanAngeloff/php.vim'
Plug 'joonty/vdebug'
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'
Plug 'phpactor/phpactor' ,  {'do': 'composer install --no-dev -o', 'for': 'php'}
Plug 'dyng/ctrlsf.vim'					"An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/echodoc.vim'				"show function signature at bottom

Plug 'ctrlpvim/ctrlp.vim'               "Fuzzy file, buffer, mru, tag, etc finder
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_cmd = 'CtrlPBuffer'


set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

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


	Plug 'ncm2/ncm2-ultisnips'
	Plug 'SirVer/ultisnips'

	" Press enter key to trigger snippet expansion
	" The parameters are the same as `:help feedkeys()`
	inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

	" c-j c-k for moving in snippet
	let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
	let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
	let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
	let g:UltiSnipsRemoveSelectModeMappings = 0

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
	Plug 'phpactor/ncm2-phpactor'
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
" map <F7> Oimport ipdb; ipdb.set_trace()
nmap <F8> :TagbarToggle<CR>
set tags=./.git/tags;,.git/tags;./tags;

" help ale-navigation-commands
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_completion_enabled = 1
let g:ale_use_global_executables = 1
let g:ale_php_phpcs_executable='phpcs'
let g:ale_php_php_cs_fixer_executable='php-cs-fixer'
let g:php_cs_fixer_path = $HOME."/bin/php-cs-fixer"
let g:php_cs_fixer_dry_run = 1
let g:ale_php_phpcs_standard = "PSR12"

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'python': ['autopep8', 'isort', 'autoimport', 'black'],
\   'css': ['prettier'],
\   'php': ['phpcbf', 'php_cs_fixer', 'trim_whitespace']
\}

let g:ale_linters = {
\   'php': ['php', 'phpcs']
\}

" Ale https://github.com/dense-analysis/ale

" FastFold
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
"do not close folds automatically
set foldlevelstart=99

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

nnoremap <leader>p :call pdv#DocumentWithSnip()<CR>
vnoremap <M-/> <Esc>/\%V

nnoremap <leader>t :call FzyCommand("ag . --silent -l -g ''", ":tabe ")<cr>
nnoremap <leader>e :call FzyCommand("ag . --silent -l -g ''", ":e ")<cr>
nnoremap <leader>v :call FzyCommand("ag . --silent -l -g ''", ":vs ")<cr>
nnoremap <leader>s :call FzyCommand("ag . --silent -l -g ''", ":sp ")<cr>
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
nnoremap <silent> <F3> :NERDTreeToggle<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" Keep search matches in the middle of the window and pulse the line when moving
" to them.
nnoremap n nzzzv:call PulseCursorLine()<cr>
nnoremap N Nzzzv:call PulseCursorLine()<cr>

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

	if has("gui_running")
		hi CursorLine guibg=#3a3a3a
		redraw
		sleep 2m

		hi CursorLine guibg=#555555
		redraw
		sleep 2m
    else
		hi CursorLine ctermbg=244
		redraw
		sleep 2m

		hi CursorLine ctermbg=250
		redraw
		sleep 2m
    endif

    execute 'hi ' . old_hi

    windo set cursorline
    execute current_window . 'wincmd w'
endfunction

let g:ack_mappings = { "go": "<CR>:call PulseCursorLine()<CR><C-W>j" }
set number relativenumber
set nu rnu

let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip"
