if executable('opam')
  let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
  let g:ocamlmerlin =  g:opamshare . "/merlin/vim"
  if isdirectory(g:ocamlmerlin)
    let g:found_merlin = 1
  endif
endif

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'lifepillar/vim-gruvbox8'

Plug 'sbdchd/neoformat'
Plug 'ocaml/vim-ocaml'
Plug 'cespare/vim-toml'
Plug 'plasticboy/vim-markdown'

Plug 'neomake/neomake'
Plug 'lifepillar/vim-mucomplete'

if g:found_merlin
  Plug g:ocamlmerlin, { 'for': 'ocaml' }
endif

call plug#end()

" Autocomplete
set shortmess+=c
set completeopt+=menuone

" Linter
call neomake#configure#automake('nw', 750)

" Basic Setup
let mapleader = "\<space>"
let maplocalleader=","
let g:mapleader = "\<space>"
let g:maplocalleader = ","
set tabstop=2
set shiftwidth=2
set expandtab
set mouse=a

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
let g:gruvbox_italicize_strings = 0
colorscheme gruvbox8

" Statusline

function! GitBranch()
  if !exists("b:git_dir")
    return ""
  endif
  return " | " . fugitive#head()
endfunction

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "Normal"
  elseif l:mode==?"v"
    return "Visual"
  elseif l:mode==#"i"
    return "Insert"
  elseif l:mode==#"R"
    return "Replace"
  elseif l:mode==?"s"
    return "Select"
  elseif l:mode==#"t"
    return "Terminal"
  elseif l:mode==#"c"
    return "Command"
  elseif l:mode==#"!"
    return "Shell"
  endif
endfunction

set laststatus=2
set statusline=
set statusline+=\ 
set statusline+=%{StatuslineMode()}
set statusline+=\ 
set statusline+=\|
set statusline+=\ %f
set statusline+=%m
set statusline+=%r
set statusline+=%{GitBranch()}
set statusline+=\ 
set statusline+=\|
set statusline+=\ %y
set statusline+=\ 
set statusline+=\|
set statusline+=\ 
set statusline+=%{strlen(&fenc)?&fenc:'no-ft'}

" show trailing spaces
set list listchars=tab:\ \ ,trail:·

" better splits
set splitbelow
set splitright

set number
set relativenumber
set cursorline
set showcmd
set lazyredraw

let g:vim_markdown_folding_disabled = 1

" Autopairs
augroup vimrc-ocaml-autopairs
  autocmd!
  autocmd FileType ocaml let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
  autocmd FileType dune let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
augroup END
