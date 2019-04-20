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
Plug 'jreybert/vimagit'

" Utilities
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'liuchengxu/vim-which-key'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Nicer colors
Plug 'junegunn/seoul256.vim'
Plug 'w0ng/vim-hybrid'
Plug 'jnurmine/Zenburn'

" Language plugins
Plug 'sbdchd/neoformat'
Plug 'let-def/ocp-indent-vim'
Plug 'rgrinberg/vim-ocaml'
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Linter
Plug 'w0rp/ale'

call plug#end()

" Deoplete
let g:deoplete#enable_at_startup = 1

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

let g:zenburn_alternate_Include = 1
let g:zenburn_disable_Label_underline = 1
let g:zenburn_enable_TagHighlight=1
let g:seoul256_srgb = 1
colorscheme zenburn

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

" Airline
let g:airline_theme='zenburn'

" Fzf

if executable('rg')
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)
endif

let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

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

" vim-signify
let g:gitgutter_sign_added          = '│'
let g:gitgutter_sign_modified       = '│'
let g:gitgutter_sign_removed = '│'

" polyglot
let g:polyglot_disabled = ['ocaml', 'rust']

" Ale
let g:ale_completion_enabled = 1
let g:ale_ocaml_ols_executable = 'ocamlmerlin-lsp'
let g:ale_fixers = {
      \   'ocaml': ['ocamlformat']
      \ }
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_rust_cargo_use_check = 1

" Autopairs
augroup vimrc-ocaml-autopairs
  autocmd!
  autocmd FileType ocaml let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
  autocmd FileType jbuild let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
augroup END

" Which-key setup
set timeoutlen=500

let g:which_key_map = {}

let g:which_key_map.f = {
      \ 'name' : '+file',
      \ 'f' : ['Files', 'list-files'],
      \ '=' : ['Neoformat', 'format-file']
      \ }

nnoremap <silent> <leader>fs :update<CR>
let g:which_key_map.f.s = 'save-file'

nnoremap <silent> <leader>fed :e $MYVIMRC<CR>
let g:which_key_map.f.e = {'d': 'open-vimrc'}

let g:which_key_map.b = {
      \ 'name' : '+buffer',
      \ '1' : ['b1', 'buffer 1'],
      \ '2' : ['b2', 'buffer 2'],
      \ 'd' : ['bd', 'delete-buffer'],
      \ 'f' : ['bfirst', 'first-buffer'],
      \ 'l' : ['blast', 'last-buffer'],
      \ 'n' : ['bnext', 'next-buffer'],
      \ 'p' : ['bprevious', 'previous-buffer'],
      \ 'b' : ['Buffers', 'list-buffers'],
      \ }

let g:which_key_map.w = {
      \ 'name': '+windows',
      \ 'd': ['<C-W>c', 'delete-window'],
      \ '-' : ['<C-W>s', 'split-window-horizontally'],
      \ '|' : ['<C-W>v', 'split-window-vertically'],
      \ '=': ['<C-W>=', 'balance-window'],
      \ 'H': ['<C-W>5<', 'expand-window-left'],
      \ 'J': ['resize +5', 'expand-window-below'],
      \ 'L': ['<C-W>5>', 'expand-window-right'],
      \ 'K': ['resize -5', 'expand-window-up']
      \ }

let g:which_key_map.p = {
      \ 'name': '+project',
      \ 'f': ['GFiles', 'list-project-files']
      \ }

call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

if has('nvim')
  " https://github.com/neovim/neovim/issues/2897#issuecomment-115464516
  let g:terminal_color_0 = '#4e4e4e'
  let g:terminal_color_1 = '#d68787'
  let g:terminal_color_2 = '#5f865f'
  let g:terminal_color_3 = '#d8af5f'
  let g:terminal_color_4 = '#85add4'
  let g:terminal_color_5 = '#d7afaf'
  let g:terminal_color_6 = '#87afaf'
  let g:terminal_color_7 = '#d0d0d0'
  let g:terminal_color_8 = '#626262'
  let g:terminal_color_9 = '#d75f87'
  let g:terminal_color_10 = '#87af87'
  let g:terminal_color_11 = '#ffd787'
  let g:terminal_color_12 = '#add4fb'
  let g:terminal_color_13 = '#ffafaf'
  let g:terminal_color_14 = '#87d7d7'
  let g:terminal_color_15 = '#e4e4e4'

  set fillchars=vert:\|,fold:-
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

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

