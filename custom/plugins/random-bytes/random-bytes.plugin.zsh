#!/bin/zsh

random_bytes() {
  node -e "console.log(require('crypto').randomBytes(256).toString('base64'))"
}
