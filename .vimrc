set nocompatible
let mapleader=","

filetype plugin on

"Numbering
set number
set ruler
set laststatus=2 "always display status line

">80char highlighting
":match ErrorMsg '\%81v.\+'
set nu

noremap <leader>ev :split ~/.vimrc<cr>
noremap <leader>sv :source ~/.vimrc<cr>

"Tabs
noremap <F10> gt
noremap <F9> gT

"Pasting (will paste last yanked thing, not just last deleted)
"( I never use these, maybe remove? )
vnoremap <leader>p "0p
nnoremap <leader>p "0p
vnoremap <leader>P "0P
nnoremap <leader>P "0P

"Move properly on wrapped lines
nnoremap j gj
nnoremap k gk

"Faster escape
inoremap jk <esc>
"Faster colon
nnoremap ; :

"Space foo => insert foo at cursor
nnoremap <space> i_<esc>r

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

" ======= Colors bs ========
"
"set t_Co=256 "hopefully force 256-color to work

"On laptop only
"let g:solarized_use16 = 1
"colorscheme solarized8

"let g:solarized_termcolors=256  "if term uses non-solarized pallete
set background=dark
"colorscheme solarized

"set syntax
syntax enable

"set colorcolumn=81
"set cursorline



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
" Gitgutter
"let g:gitgutter_enabled = 1
set updatetime=400 "default 4000 (4sec), makes signs faster
"set signcolumn=yes "force sign column always

" youcompleteme
if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']


"Nerdtree
nnoremap <F4> :NERDTreeToggle<CR>
