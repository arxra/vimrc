if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" ================ Plugins ==================== {{{
call plug#begin( '~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree' " usefull for moving files.
Plug 'donRaphaco/neotex'
Plug 'tmsvg/pear-tree' 
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'

"----------------- Eye candy --------------
Plug 'ryanoasis/vim-devicons'
Plug 'chriskempson/base16-vim'
Plug 'Yggdroot/indentLine' "Looks good, mostly
Plug 'vim-airline/vim-airline'

"----------------- Fuzzy finder--------------
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"----------------- VCS ----------------------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree' "Local 'git' for undo history

"----------------- Language packs -----------
Plug 'mxw/vim-prolog'
Plug 'cespare/vim-toml'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'lervag/vimtex'
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'slashmili/alchemist.vim' "Elixir

"--- Auto complettion engines and plugs------
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'liuchengxu/vista.vim' " Shows the structure of the doc, uses coc as provider

call plug#end()
"}}}
" ================ Load additional files ===========================
"execute 'source $HOME/.config/nvim/functions.vim' 
" ================ Autopairs===========================
" Default rules for matching:
let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ '<': {'closer': '>'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'},
            \ '<*>': {'closer': '</*>'}
            \ }
" See pear-tree/ftplugin/ for filetype-specific matching rules

" Pear Tree is enabled for all filetypes by default
let g:pear_tree_ft_disabled = []

" Pair expansion is dot-repeatable by default
let g:pear_tree_repeatable_expand = 1

" Smart pairs are disabled by default
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

imap <BS> <Plug>(PearTreeBackspace)
imap <Esc> <Plug>(PearTreeFinishExpansion)

" ================ Split ===========================
set splitbelow splitright


" ================ Keybinds ========================={{{
" Leader stuff
nnoremap <SPACE> <Nop>
let mapleader=" "
nnoremap <leader><leader> <c-^>

" quicksave
nnoremap <c-s> :update<CR>
inoremap <c-s> <c-o>:update<CR>

" Orientation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"F keys Toggle key
map <silent><F2> :NERDTreeToggle<CR>
map <silent><F3> :Vista!!<CR>
map <silent><F4> :Helptags<CR>
map <F5> :UndotreeToggle<cr>

 "keybind allows exiting IEx via Esc
if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
endif
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" ================== Vista confs ======================= {{{
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_executive_for = {
  \ 'javascript': 'coc',
  \ 'typescript': 'coc',
  \ 'javascript.jsx': 'coc',
  \ 'python': 'coc',
  \ 'c++': 'coc',
  \ 'rust': 'coc',
  \ 'vimwiki': 'ctags',
  \ }


" ================== Theme and Look ======================= {{{
" Colours and shit 
set t_Co=256
colorscheme base16-gruvbox-dark-pale
set termguicolors
set guicursor=i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150

hi SpellBad cterm=underline
let g:indentLine_fileTypeExclude = ['tex', 'markdown']
set spelllang=sv,en
filetype plugin on
syntax on

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#enable_icon = 1

"Airline manual stuff
let g:airline#extensions#virtualenv#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

"C++ specific highliting 
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1



" ================== Linting ======================= {{{
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]



" ================== Linting ======================= {{{
let g:rustfmt_command = "rustfmt"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

let g:vimtex_format_enabled = 1

nmap <leader>f <Plug>(coc-format):w<cr>:w<cr>


" ================ Concour of Code ================== {{{
set hidden
set cmdheight=2
set updatetime=300
set signcolumn=yes
autocmd CursorHold * silent call CocActionAsync('highlight')
inoremap <silent><expr> <c-space> coc#refresh()
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)


" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" navigate diagnostics
nmap <silent> <leader>h <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>l <Plug>(coc-diagnostic-next)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Custom Commands
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" ============ Fuzzy searching ============ {{{
" <leader>s for Rg search
noremap <leader>s :Rooter<cr>:Rg<cr>
noremap <leader>b :Buffers<cr>
let g:fzf_layout = { 'down': '~20%' }
let g:rooter_manual_only = 1

" 
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif


command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

" Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

" Always show preview
let g:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,
         \intermediate/*,*.o,*.hi,Zend,vendor
         \*.pys


 

" === Persistent Undo and buffer changes ============ {{{

" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set undodir=~/.config/nvim/backups
set undofile
set autowrite

" ================ Indentation ====================== {{{
set relativenumber
set number
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set smartindent
set nofoldenable
set colorcolumn=120
set foldmethod=syntax
let g:indentLine_char = '│'
