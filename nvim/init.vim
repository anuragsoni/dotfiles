let g:python3_host_prog='/Users/asoni/Code/Python/neovim/bin/python'

if executable('opam')
  let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
  let g:ocamlmerlin =  g:opamshare . "/merlin/vim"
  let g:ocamlocpindent = g:opamshare . "/ocp-indent/vim"
  if isdirectory(g:ocamlmerlin)
    let g:found_merlin = 1
  else
    let g:found_merlin = 0
  endif
  if isdirectory(g:ocamlocpindent)
    let g:found_ocpindent = 1
  else
    let g:found_ocpindent = 0
  endif
endif

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'Yggdroot/indentLine'

Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'

Plug 'lifepillar/vim-gruvbox8'

Plug 'sbdchd/neoformat'
Plug 'ocaml/vim-ocaml'
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'cespare/vim-toml'
Plug 'plasticboy/vim-markdown'
Plug 'derekwyatt/vim-scala'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'

Plug 'neomake/neomake'
Plug 'lifepillar/vim-mucomplete'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" if g:found_ocpindent
"   Plug g:ocamlocpindent, { 'for': 'ocaml' }
" endif
" if g:found_merlin
"   Plug g:ocamlmerlin, { 'for': 'ocaml' }
" endif

call plug#end()

" LSP
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
    \ 'ocaml': ['ocamllsp']
    \ }
function SetupLspKeybindings()
  nmap <silent>K <Plug>(lcn-hover)
  nmap <silent>gd <Plug>(lcn-definition)
  nmap <silent>lt <Plug>(lcn-type-definition)
  nmap <silent>lm <Plug>(lcn-menu)
  nmap <silent>la <Plug>(lcn-code-action)
  nmap <silent>lca <Plug>(lcn-code-lens-action)
  nmap <silent>lh <Plug>(lcn-highlight)
  nmap <silent>lee <Plug>(lcn-explain-error)
  nmap <silent>lf <Plug>(lcn-format)
  nmap <silent>lr <Plug>(lcn-rename)
endfunction()
augroup LSP
  autocmd!
  autocmd FileType rust,ocaml call SetupLspKeybindings()
augroup END

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
set updatetime=100

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
  set termguicolors
endif

set background=light
let g:gruvbox_italicize_strings = 0
let g:gruvbox_italics = 0
let g:gruvbox_bold = 1
let g:gruvbox_plugin_hi_groups = 1
let g:gruvbox_filetype_hi_groups = 1
colorscheme gruvbox8_soft

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

" show trailing spaces
set list
set listchars=tab:»-,extends:»,precedes:«,trail:.

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

" Git utils
let g:signify_sign_add    = '┃'
let g:signify_sign_change = '┃'
let g:signify_sign_delete = '•'

let g:signify_sign_show_count = 0 " Don’t show the number of deleted lines.
nnoremap <leader>gp :SignifyHunkDiff<cr>
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

set diffopt+=internal,filler,algorithm:histogram

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
