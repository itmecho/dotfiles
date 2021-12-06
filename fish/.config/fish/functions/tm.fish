function tm
    set -l create "Create session"
    set -l switch "Switch session"

    set session_count (tmux list-sessions | wc -l)

    set -l actions
    test $session_count -gt 0; and set -l -a actions $switch
    set -l -a actions $create
    set action (string join \n $actions | fzf)

    switch $action
        case $create
            read -P 'Session name: ' name
            tmux new-session -d -t $name
            tmux switch-session -t $name
        case $switch
            set session (tmux list-sessions -F '#S' | fzf)
            if test -z $TMUX
                tmux a -t $session
            else
                tmux switch-client -t $session
            end
    end
end
