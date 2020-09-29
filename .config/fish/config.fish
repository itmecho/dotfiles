#!/usr/bin/fish

set fish_greeting

set SHELL                  /usr/bin/fish
set GOPATH                 $HOME/src/go
set PATH                   $PATH:$HOME/bin:$GOPATH/bin:$HOME/.local/bin:$HOME/.pulumi/bin:$HOME/.cargo/bin
set EDITOR                 nvim
set FZF_DEFAULT_COMMAND    "rg --files"
set NAVI_PATH              $HOME/.config/navi
set FZF_DEAFULT_OPTS       ' --no-exact'
set NAVI_FZF_OVERRIDES     ' --no-exact'
set NAVI_FZF_OVERRIDES_VAR ' --no-exact'
set GPG_TTY                (tty)

alias ls     "lsd --group-dirs first"
alias ll     "ls -lAh"
alias l      "ls -lh"
alias cat    "bat -pp --theme Nord"
alias vi     "nvim"
alias vim    "nvim"
alias watch  'watch '
alias gs     "git status"
alias gcm    "git commit -S -m"
alias gpnew  'git push -u origin (git rev-parse --abbrev-ref HEAD)'
alias k      "kubectl"
alias kx     "kubectx"
alias kn     "kubens"
alias config "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

gpg-connect-agent updatestartuptty /bye >/dev/null

starship init fish | source
navi widget fish | source

if [ -z $DISPLAY ] && [ (tty) = /dev/tty1 ]
    startx
end
