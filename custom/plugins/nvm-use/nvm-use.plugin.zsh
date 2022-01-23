# Call `nvm use` automatically
# See: https://github.com/nvm-sh/nvm#zsh
nvm-use() {
  local nvm_path=$(nvm_find_nvmrc)

  # If there isn't .nvmrc file, use the default nvm version
  if [[ $nvm_path == "" ]]; then
    local default_version
    default_version=$(nvm version default)

    # If there is no default version, set it to `node`
    # This will use the latest version on your machine
    if [[ $default_version == "N/A" ]]; then
      nvm alias default node
      default_version=$(nvm version default)
    fi

    # If current version is not the default, use default node version
    if [[ $(nvm current) != "$default_version" ]]; then
      nvm use default
    fi
  elif [ -f "$nvm_path" ]; then
    local nvm_version=$(<"$nvm_path")

    local local_version
    # `nvm ls` will check all locally-available versions
    # If there are multiple matches, take the latest one
    # Remove `->` and `*` characters and spaces
    # `local_version` will be `N/A` if no local versions are found
    local_version=$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')

    # If not already installed, install it
    # `nvm install` will implicitly use newly-installed version
    if [[ "$local_version" == "N/A" ]]; then
      nvm install "$nvm_version"
    elif [[ $(nvm current) != "$local_version" ]]; then
      nvm use "$nvm_version"
    fi
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd nvm-use

nvm-use
