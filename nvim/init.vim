if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Defaults that most people can agree on
Plug 'tpope/vim-sensible'

" Git utilities
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'

" Utilities
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'

" Nicer colors
Plug 'icymind/NeoSolarized'

" Language plugins
Plug 'sbdchd/neoformat'
Plug 'let-def/ocp-indent-vim'
Plug 'rgrinberg/vim-ocaml'
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'

" Autocompletion
Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim'
Plug 'copy/deoplete-ocaml'

" Linter
Plug 'w0rp/ale'

call plug#end()

" Basic Setup
let mapleader = "\<space>"
let maplocalleader="\<space>"
let g:mapleader = "\<space>"
set tabstop=2
set shiftwidth=2
set expandtab

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

set background=light
let g:neosolarized_italic = 1
colorscheme NeoSolarized

" show trailing spaces
set list listchars=tab:\ \ ,trail:·

" better splits
set splitbelow
set splitright

function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  return '[%n] %F %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()

set number
set cursorline
set showcmd
set lazyredraw

" Nerdtree settings
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" Deoplete
let g:deoplete#enable_at_startup = 1

" Ctrlp
if executable('rg')
  set grepprg=rg
  let g:ctrlp_user_command = 'rg %s --files --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
endif

" polyglot
let g:polyglot_disabled = ['ocaml', 'rust']

" Ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_rust_cargo_use_check = 1

" Autopairs
augroup vimrc-ocaml-autopairs
  autocmd!
  autocmd FileType ocaml let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
  autocmd FileType jbuild let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
augroup END

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

