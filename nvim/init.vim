if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Defaults that most people can agree on
Plug 'tpope/vim-sensible'

" Git utilities
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Utilities
Plug 'edkolev/tmuxline.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'

" Nicer colors
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'

" Language plugins
Plug 'sbdchd/neoformat'
Plug 'ocaml/vim-ocaml'
Plug 'cespare/vim-toml'
Plug 'plasticboy/vim-markdown'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Lint
Plug 'dense-analysis/ale'

call plug#end()

let g:airline_symbols_ascii = 1

" Autocomplete
let g:deoplete#enable_at_startup = 1
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = 'minimal'
let g:float_preview#docked = 0

" Basic Setup
let mapleader = "\<space>"
let maplocalleader=","
let g:mapleader = "\<space>"
let g:maplocalleader = ","
set tabstop=2
set shiftwidth=2
set expandtab
set updatetime=100

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
if v:version >= 703
  set undodir=/tmp//,.
endif

" Prevent vim from automatically commenting lines
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set clipboard=unnamedplus

" Search
if has('nvim')
  set incsearch
endif
set hlsearch
set ignorecase
set smartcase
set wrapscan

set mouse=a
if exists('&inccommand')
  set inccommand=nosplit
endif

if exists('&inccomand')
  set inccommand=nosplit
endif

set formatoptions+=1
if has('patch-7.3.541')
  set formatoptions+=j
endif
if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent
  set breakindentopt=sbr
endif

" UI
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set background=dark
let g:solarized_italics=0
colorscheme solarized8

" show trailing spaces
set list listchars=tab:\ \ ,trail:·

" better splits
set splitbelow
set splitright

set number
set cursorline
set showcmd
set lazyredraw

" Nerdtree settings
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" Git markers
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added          = '│'
let g:gitgutter_sign_modified       = '│'
let g:gitgutter_sign_removed = '│'
set diffopt+=internal,filler,algorithm:histogram

" FZF
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Autopairs
augroup vimrc-ocaml-autopairs
  autocmd!
  autocmd FileType ocaml let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
  autocmd FileType jbuild let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
augroup END

let g:vim_markdown_folding_disabled = 1
