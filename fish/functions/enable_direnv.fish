function enable_direnv
  if type -q direnv
    eval (direnv hook fish)
  else
    echo "direnv is not installed"
  end
end
