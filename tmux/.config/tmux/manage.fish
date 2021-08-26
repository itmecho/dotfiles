#!/usr/bin/env fish

function go-to-session
	set -l name $argv[1]
	set -l subcommand switch-client
	test -z $TMUX; and set -l subcommand attach-session
	tmux $subcommand -t $name
end

function select-session
	tmux list-sessions | rofi -dmenu | cut -d':' -f1
end

set -l cmds "Create Session"
tmux list-sessions &>/dev/null; and set -la cmds "Switch Session" "Kill Session"

set -l cmd (printf '%s\n' $cmds| rofi -dmenu -i -p 'tmux')

switch $cmd
	case "Create Session"
		set -l name (rofi -dmenu -lines 0 -p 'Session name')
		test -z $name; and exit
		tmux new-session -d -c $HOME -s $name
		go-to-session $name
	case "Switch Session"
		set -l name (select-session)
		test -z $name; and exit
		go-to-session $name
	case "Kill Session"
		set -l name (select-session)
		tmux kill-session -t $name
end

exit 0
