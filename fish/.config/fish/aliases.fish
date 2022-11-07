# General
alias bat 'bat --theme Dracula'
alias cat 'bat -pp'
alias cb 'xclip -i -selection clipboard'
alias cdc 'cd $CLOUDPATH'
alias cdcp 'cd (cd $CLOUDPATH; fd --max-depth 2 --type d | fzf)'
alias cdn 'cd ~/Documents/notes'
alias l 'ls -lh'
alias ll 'ls -lAh'
alias ls 'lsd --group-dirs first'
alias mkdir 'mkdir -p'
alias uuidgen "uuidgen | tr '[:upper:]' '[:lower:]'"
alias vi nvim
alias vim nvim
alias tf 'terraform'
alias nw 'kitty @ set-tab-title neorg && nvim -c "Neorg workspace work"'

# Git
alias g git
alias ga 'git add'
alias gapa 'git add --interactive --patch'
alias gb 'git switch'
alias gbb 'git branch -a --format "%(refname:short)" | fzf | sed "s,origin/,," | xargs git switch'
alias gc 'git commit'
alias gco 'git checkout'
alias gcq 'git commit --amend --no-edit'
alias gd 'git diff'
alias gdca 'git diff --cached'
alias gp 'git push'
alias gpl 'git pull'
alias gpnew 'git push -u origin (git rev-parse --abbrev-ref HEAD)'
alias gs 'git status'

# K8s
alias k kubectl
alias kn kubens
alias kx kubectx
