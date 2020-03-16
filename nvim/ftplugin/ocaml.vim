call ale#linter#Define('ocaml', {
      \ 'name': 'ocaml-lsp',
      \ 'lsp': 'stdio',
      \ 'executable': 'ocamllsp',
      \ 'command': '%e',
      \ 'project_root': function('ale#handlers#ols#GetProjectRoot')
      \ })
nmap <silent><buffer> gd  <Plug>(ale_go_to_definition_in_split)<CR>
nnoremap <silent> <LocalLeader>gb <C-O>
nmap , <LocalLeader>
vmap , <LocalLeader>
nmap <silent><buffer> <LocalLeader>hh <Plug>(ale_hover)<CR>
