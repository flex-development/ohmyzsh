#!/bin/zsh

git_kata_ac() {
  git ac "feat(katas): \`$1\`

- https://codewars.com/kata/$2" $3
}

git_kata_cm() {
  git cm "feat(katas): \`$1\`

- https://codewars.com/kata/$2" $3
}

alias git.kata.ac="git_kata_ac"
alias git.kata.cm="git_kata_cm"
