set nocompatible
let mapleader=" "


"Numbering
set number
set ruler
set laststatus=2 "always display status line

">80char highlighting
":match ErrorMsg '\%81v.\+'
set nu

"" Default colorcolumn to 80 chars.
set colorcolumn=80

"===================================================
"
"                  BASIC MAPPINGS
"
"===================================================

"Move properly on wrapped lines
nnoremap j gj
nnoremap k gk

"Faster escape
inoremap jk <esc>

"Tabs
noremap <F10> gt
noremap <F9> gT

" Fixing copy-paste to be sane (x doesn't modify yank buffers)
nnoremap x "_x
vnoremap x "_x
" if we want to delete without cutting (this doesn't work quite right)
" nnoremap <leader>d  "_d

"Faster colon
nnoremap ; :

"===================================================
"
"                LEADER MAPPINGS
"
"===================================================

noremap <leader>ev :split ~/.vimrc<cr>
noremap <leader>sv :source ~/.vimrc<cr>

"save, quit
noremap <leader>w :w<cr>
noremap <leader>q :q<cr>

" clear trailing whitespace
noremap <leader>cws :%s/\v\s+$//gc<CR>

" Toggle paste mode mode with <leader>pp ( for pasting with ctrl-shift-v into term)
nnoremap <leader>pp :set paste! paste?<CR>

"Space foo => insert foo at cursor
nnoremap <leader><Space> i<Space><esc>
nnoremap <leader>; i;<esc>
nnoremap <leader>, i,<esc>
"OLD, USED TO JUST BE ON <space>: "nnoremap <leader>i i_<esc>r

"======= END LEADER MAPPINGS =======

"Search options
set ignorecase
set smartcase
set hlsearch                        "Highlight Search
set incsearch                       "Highlight incrementally

"Clear search and fix syntax
"also do checktime (reloads files)
nnoremap <C-l> :nohlsearch<CR>:syntax sync fromstart<CR>:checktime<CR><C-l>
set magic

"Tabbing
set softtabstop=4  "tab/backspace behaviour in insert mode
set shiftwidth=4   "affects < and >
set shiftround     "< and > shift to shiftwidth-sized stops
set tabstop=4      "width of hard tabs
set expandtab      "tabs inserted as spaces
set autoindent

"removes ~ files
set nobackup
set undodir=~/.vim/.undo// "for .un~ files
"set directory=~/.vim/.swp// "for swap files

"Filename autocomplete
set wildmode=longest,list,full
set wildmenu


"Folds
"fold.txt
"marker mode
"&foldmarker, &commentstring
"Folds on {{{ foo }}}
set foldmethod=marker

nohlsearch


" == Autocmds
"FocusGained doesnt work in tmux
augroup vimrc
    autocmd!
    au WinEnter,FocusGained * checktime
augroup END


" =========== PLUGINS ===========

" Install vim-plug by doing the following:
"    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" === vim-plug:
call plug#begin()
Plug 'vim-python/python-syntax'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'

if has('nvim')
    Plug 'neovim/nvim-lspconfig' " basic rust-analyzer client
    Plug 'mrcjkb/rustaceanvim' " fancy rust-v:Pnalyzer client, ???
else
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
endif

Plug 'rust-lang/rust.vim'
"NOTE: If YCM doesn't work, can run install script manually:
"    cd $HOME/.vim/plugged/YouCompleteMe
"    python3 ./install.py
"(See notes here: https://github.com/ycm-core/YouCompleteMe/issues/1751)
"install.py can be called with various options
" --all is good, but has prereqs
"  --clangd-completer, --ts-completer, etc
"  --help will list helpful options
call plug#end()
" reload vimrc and call :PlugInstall to install

" === Individual plugin settings

" PLUG: python-syntax
let g:python_highlight_all = 1

" PLUG: Gitgutter
let g:gitgutter_enabled = 1
set updatetime=400 "default 4000 (4sec), makes signs faster
"set signcolumn=yes "force sign column always

" PLUG: youcompleteme
nnoremap <leader>yr :YcmRestartServer<CR>
" YCM Jumps: they use the jumplist so can use Ctrl-O and Ctrl-I to go back/forward
nnoremap <leader>jj :YcmCompleter GoTo<CR>
nnoremap <leader>ji :YcmCompleter GoToInclude<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jr :YcmCompleter GoToReferences<CR>
" if !exists("g:ycm_semantic_triggers")
"   let g:ycm_semantic_triggers = {}
" endif
" let g:ycm_semantic_triggers['typescript'] = ['.']

" Configure LSP stuff
if has('nvim')
    "lua require'lspconfig'.rust_analyzer.setup{}
endif


" PLUG: Nerdtree
nnoremap <F4> :NERDTreeToggle<CR>


" ======= Colors bs ========
"
set t_Co=256 "hopefully force 256-color to work
"set termguicolors

"On laptop only
"let g:solarized_use16 = 1
"colorscheme solarized8
"let g:solarized_termcolors=256  "if term uses non-solarized pallete
set background=light
"colorscheme solarized
colorscheme gruvbox

"set syntax
syntax enable
filetype plugin indent on

"set colorcolumn=81
"set cursorline
