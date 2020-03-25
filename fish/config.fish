# opam configuration
source /home/asoni/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

alias enable_nix 'exec bash -c ". ~/.nix-profile/etc/profile.d/nix.sh; exec fish"'
