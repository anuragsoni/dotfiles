function enable_nix
  if test -f ~/.nix-profile/etc/profile.d/nix.sh
    exec bash -c ". ~/.nix-profile/etc/profile.d/nix.sh; exec fish"
  else
    echo "nix is not installed"
  end
end
