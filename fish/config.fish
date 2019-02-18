# opam configuration
source /home/asoni/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
source ~/.asdf/asdf.fish

switch (uname -a)
case "*Microsoft*"
  umask 22 # WSL needs umask value set for proper file permissions
end

set -x QT_AUTO_SCREEN_SCALE_FACTOR 1
