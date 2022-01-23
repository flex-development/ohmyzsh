jwt_secret() {
  node -e "console.log(require('crypto').randomBytes(256).toString('base64'))"
}

autoload -U add-zsh-hook
add-zsh-hook chpwd jwt_secret
