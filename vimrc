" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')


" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips'
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
Plug 'zhimsel/vim-stay'					"stay at previously colsed position
Plug 'tmhedberg/SimpylFold'				"simple, correct folding for Python
Plug 'fatih/vim-go'						"Go development plugin
Plug 'easymotion/vim-easymotion'		"moving shortcuts
Plug 'ludovicchabant/vim-gutentags'     "tags creation automatically
Plug 'stephpy/vim-php-cs-fixer'
Plug 'StanAngeloff/php.vim'
Plug 'joonty/vdebug'
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'
Plug 'phpactor/phpactor' ,  {'do': 'composer install --no-dev -o', 'for': 'php'}
Plug 'dyng/ctrlsf.vim'					"An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
Plug 'neoclide/coc.nvim', {'branch': 'release'} " completion plugin


if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

if has('nvim')
	" ncm2 completion framework configurations
	Plug 'roxma/nvim-yarp'

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
endif

Plug 'embear/vim-localvimrc'  " local vimrc files

" Initialize plugin system
call plug#end()

syntax on
filetype plugin indent on
let mapleader=','

"let g:solarized_termcolors=16|256
set background=dark
colorscheme solarized

let Tlist_Use_Right_Window = 1
" map <F7> Oimport ipdb; ipdb.set_trace()
nmap <F8> :TagbarToggle<CR>
set tags=./.git/tags;,.git/tags;./tags;

" help ale-navigation-commands
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'python': ['autopep8', 'yapf', 'isort'],
\   'css': ['prettier']
\}
let g:php_cs_fixer_path = $HOME."/bin/php-cs-fixer"
let g:php_cs_fixer_dry_run = 1

" Ale https://github.com/dense-analysis/ale

" FastFold
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
"do not close folds automatically
set foldlevelstart=99

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

nnoremap <leader>p :call pdv#DocumentWithSnip()<CR>
vnoremap <M-/> <Esc>/\%V

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

" }}}

let g:ack_mappings = { "go": "<CR>:call PulseCursorLine()<CR><C-W>j" }
set number relativenumber
set nu rnu

let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip"

"coc.vim
	" TextEdit might fail if hidden is not set.
	set hidden

	" Some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup

	" Give more space for displaying messages.
	set cmdheight=2

	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
	" delays and poor user experience.
	set updatetime=300

	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	if has("patch-8.1.1564")
	  " Recently vim can merge signcolumn and number column into one
	  set signcolumn=number
	else
	  set signcolumn=yes
	endif

	" Use tab for trigger completion with characters ahead and navigate.
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config.
	inoremap <silent><expr> <TAB>
		  \ pumvisible() ? "\<C-n>" :
		  \ <SID>check_back_space() ? "\<TAB>" :
		  \ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()

	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
	" position. Coc only does snippet and additional edit on confirm.
	" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
	if exists('*complete_info')
	  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
	else
	  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	endif

	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
	  if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	  else
		call CocAction('doHover')
	  endif
	endfunction

	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Symbol renaming.
	nmap <leader>rn <Plug>(coc-rename)

	" Formatting selected code.
	xmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)

	augroup mygroup
	  autocmd!
	  " Setup formatexpr specified filetype(s).
	  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	  " Update signature help on jump placeholder.
	  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Applying codeAction to the selected region.
	" Example: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap keys for applying codeAction to the current buffer.
	nmap <leader>ac  <Plug>(coc-codeaction)
	" Apply AutoFix to problem on the current line.
	nmap <leader>qf  <Plug>(coc-fix-current)

	" Map function and class text objects
	" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
	xmap if <Plug>(coc-funcobj-i)
	omap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap af <Plug>(coc-funcobj-a)
	xmap ic <Plug>(coc-classobj-i)
	omap ic <Plug>(coc-classobj-i)
	xmap ac <Plug>(coc-classobj-a)
	omap ac <Plug>(coc-classobj-a)

	" Use CTRL-S for selections ranges.
	" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
	nmap <silent> <C-s> <Plug>(coc-range-select)
	xmap <silent> <C-s> <Plug>(coc-range-select)

	" Add `:Format` command to format current buffer.
	command! -nargs=0 Format :call CocAction('format')

	" Add `:Fold` command to fold current buffer.
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	" Add `:OR` command for organize imports of the current buffer.
	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

	" Add (Neo)Vim's native statusline support.
	" NOTE: Please see `:h coc-status` for integrations with external plugins that
	" provide custom statusline: lightline.vim, vim-airline.
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

	" Mappings for CoCList
	" Show all diagnostics.
	nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
	" Manage extensions.
	nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
	" Show commands.
	nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document.
	nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols.
	nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
	" Resume latest coc list.
	nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
