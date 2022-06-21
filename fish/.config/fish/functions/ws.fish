function ws --description "Kitty workspace management script"
	set -l projects work eden
	set -l project $argv[1]

	if test -z $project
		set project (echo $projects | sed 's/ /\n/g' | fzf)
	end

	if test -z $project
		echo "project is required"
		return 1
	end

	switch $project
		case "work"
		cd ~/src/CloudExperiments
		kitty @ set-tab-title "neovim"
		kitty @ new-window --new-tab --tab-title "fish" --cwd ~/src/CloudExperiments
		kitty @ focus-tab -m title:neovim
		nvim
	case "eden"
		kitty @ set-tab-title "eden"
		cd ~/src/eden
		kitty @ new-window --new-tab --tab-title "eden-ui" --cwd ~/src/eden/ui
		kitty @ new-window --new-tab --tab-title "server" --cwd ~/src/eden

		kitty @ send-text -t title:eden "nvim\n"
		kitty @ send-text -t title:eden-ui "nvim\n"
		kitty @ send-text -t title:server "make dev\n"
		kitty @ focus-tab -m title:eden
		nvim
	case '*'
		echo >&2 "unsupported project '$project'"
		return 1
	end
end
