alias bat 'bat --theme Dracula'
alias cat 'bat -pp'
alias cdc 'cd $CLOUDPATH'
alias cdcp 'cd (cd $CLOUDPATH; fd --max-depth 2 --type d | fzf)'
alias cdn 'cd ~/Documents/notes'
alias g git
alias gs 'g s'
alias gpnew 'git push -u origin (git rev-parse --abbrev-ref HEAD)'
alias k kubectl
alias kn kubens
alias kx kubectx
alias l 'ls -lh'
alias ll 'ls -lAh'
alias ls 'lsd --group-dirs first'
alias mkdir 'mkdir -p'
alias uuidgen "uuidgen | tr '[:upper:]' '[:lower:]'"
alias vi nvim
alias vim nvim
alias work 'tmux new-session -s work -c $CLOUDPATH'
