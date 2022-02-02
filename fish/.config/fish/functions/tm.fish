function tm
    set -l create "Create session"
    set -l kill_session "Kill session"
    set -l switch "Switch session"

    set -l session_count (tmux list-sessions 2>/dev/null | wc -l)

    set -l actions

    # If there is an existing session, allow switching sessions
    test $session_count -gt 0
    and set -a actions $switch $kill_session

    # Add the default actions
    set -l -a actions $create

    # Select an action
    set action (string join \n $actions | fzf)

    switch $action
        case $create
            read -P 'Session name: ' name
            tmux new-session -d -s $name
            if [ -z $TMUX ]
                tmux attach-session -t $name $extra_args
            else
                tmux switch-client -t $name
            end
        case $kill_session
            set -l session_list (tmux list-sessions -F '#S')
            set -l session (string join \n $session_list | fzf)
            tmux kill-session -t $session
        case $switch
            set session (tmux list-sessions -F '#S' | fzf)
            if test -z $TMUX
                tmux a -t $session
            else
                tmux switch-client -t $session
            end
    end
end
