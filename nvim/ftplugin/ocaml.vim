if executable('ocamllsp')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'ocamllsp',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'ocamllsp']},
        \ 'whitelist': ['ocaml', 'dune'],
        \ })
endif
