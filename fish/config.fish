set PATH ~/bin ~/.cargo/bin $PATH

# opam configuration
source /home/asoni/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

alias icat "kitty +kitten icat"
alias d "kitty +kitten diff"
alias gdiff "git difftool --no-symlinks --dir-diff"
