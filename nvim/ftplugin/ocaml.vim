map <buffer> <LocalLeader>y :MerlinYankLatestType<return>
nmap <LocalLeader>r <Plug>(MerlinRename)

function! ExtractLocalOpen()
    let mod = expand("<cword>")
    execute "normal! Vap\<esc>"
    execute "'<,'>s/" . mod. "\.//g"
    '<
    execute "normal! olet open " . mod . " in\<esc>"
  endfunction
nmap <LocalLeader>o :call ExtractLocalOpen()<cr>

" dune
nmap <LocalLeader>dt :! dune runtest<cr>
nmap <LocalLeader>dp :! dune promote<cr>
nmap <LocalLeader>db :! dune build<cr>
