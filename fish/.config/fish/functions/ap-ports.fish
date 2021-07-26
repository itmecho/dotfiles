function ap-ports --description "Opens panes for each port foward for admin portal"
	if test -z "$TMUX";
		echo 'only works in a tmux session'
		return
	end
	tmux split-window -d -t 0 -h 'echo schoolman; k port-forward deploy/schoolman-deployment-default 3011:3000'
	tmux split-window -d -t 1 'echo wondewitch; k port-forward deploy/wondewitch-deployment-default 3013:3000'
	tmux split-window -d -t 0 'echo schoolkeycontacts; k port-forward deploy/schoolkeycontacts-deployment-default 3012:3000'
	echo schoolstore
	k port-forward deploy/schoolstore-deployment-default 3010:3000
	tmux kill-pane -a -t 0
end
