function ws --description "Kitty workspace management script"
	set -l project $argv[1]

	if test -z $project
		echo "project required"
		return 1
	end

	switch $project
		case "work"
		cd ~/src/CloudExperiments
		kitty @ set-tab-title "neovim"
		kitty @ new-window --new-tab --tab-title "fish" --cwd ~/src/CloudExperiments
		kitty @ focus-tab -m title:neovim
		nvim
	case "gyft"
		kitty @ set-tab-title "gyft-ui"
		cd ~/src/gyft-ui
		kitty @ new-window --new-tab --tab-title "gyft" --cwd ~/src/gyft
		kitty @ new-window --new-tab --tab-title "server" --cwd ~/src/gyft

		kitty @ send-text -t title:gyft "nvim\n"
		kitty @ send-text -t title:server "while true; echo 'starting server'; go run ./cmd/server; end\n"
		kitty @ focus-tab -m title:gyft-ui
		nvim
	case '*'
		echo >&2 "unsupported project '$project'"
		return 1
	end
end
