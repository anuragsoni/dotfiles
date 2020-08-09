if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Git utilities
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Utilities
Plug 'tpope/vim-sensible'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug '/opt/local/share/fzf/vim'
Plug 'junegunn/fzf.vim'

" Nicer colors
Plug 'lifepillar/vim-gruvbox8'

" Language plugins
Plug 'sbdchd/neoformat'
Plug 'ocaml/vim-ocaml'
Plug 'cespare/vim-toml'
Plug 'plasticboy/vim-markdown'

" Autocomplete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

call plug#end()

" Autocomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

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
  " set termguicolors
endif

set background=dark
" let g:seoul256_background = 235
let g:gruvbox_italicize_strings = 0
colorscheme gruvbox8

" Statusline

function! LinterStatus() abort
  let l:all_errors = lsp#get_buffer_diagnostics_counts()["error"]
  let l:all_non_errors = lsp#get_buffer_diagnostics_counts()["warning"]
  let l:total = all_errors + all_non_errors

  return l:total == 0 ? 'OK | ' : printf(
  \   '%dW %dE | ',
  \   all_non_errors,
  \   all_errors
  \)
endfunction

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
" set statusline+=\ 
" set statusline+=\|
" set statusline+=\ 
" set statusline+=%{FugitiveHead()}
set statusline+=%=
set statusline+=%{LinterStatus()}
set statusline+=%y
set statusline+=\ 
set statusline+=\|
set statusline+=\ 
set statusline+=%{strlen(&fenc)?&fenc:'no-ft'}
set statusline+=\ 
set statusline+=\|
set statusline+=\ 
set statusline+=%2p%%
set statusline+=\ 
set statusline+=\|
set statusline+=\ 
set statusline+=%l
set statusline+=:
set statusline+=%L
set statusline+=\ 

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
