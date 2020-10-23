#!/usr/bin/fish

set fish_greeting
set -gx PATH $HOME/bin $GOPATH/bin $HOME/.local/bin $HOME/.pulumi/bin $HOME/.cargo/bin $PATH

export SHELL=/usr/bin/fish
export GOPATH=$HOME/src/go
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='rg --files'
export NAVI_PATH="$HOME/.config/cheats"
export FZF_DEAFULT_OPTS=' --no-exact'
export NAVI_FZF_OVERRIDES=' --no-exact'
export NAVI_FZF_OVERRIDES_VAR=' --no-exact'
export GPG_TTY=(tty)

alias cat    'bat -pp --theme Dracula'
alias config '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ga     'git add'
alias gapa   'git add -p'
alias gcm    'git commit -S -m'
alias gco    'git checkout'
alias gd     'git diff'
alias gdca   'git diff --cached'
alias gl     'git pull'
alias gp     'git push'
alias gpnew  'git push -u origin (git rev-parse --abbrev-ref HEAD)'
alias gs     'git status'
alias k      'kubectl'
alias kn     'kubens'
alias kx     'kubectx'
alias l      'ls -lh'
alias ll     'ls -lAh'
alias ls     'lsd --group-dirs first'
alias vi     'nvim'
alias vim    'nvim'
alias watch  'watch '

gpg-connect-agent updatestartuptty /bye >/dev/null

fzf_key_bindings
starship init fish | source
navi widget fish | source
thefuck --alias | source

if [ -z $DISPLAY ] && [ (tty) = /dev/tty1 ]
    startx
end
