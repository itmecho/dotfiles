#!/usr/bin/fish

set fish_greeting

set -gx SHELL /usr/bin/fish
test (uname) = "Darwin"; and set -gx SHELL /usr/local/bin/fish

set -gx BARX_NO_REMOTE_CACHE 1
set -gx TERM xterm-256color
set -gx NVM_DIR $HOME/.local/nvm
set -gx EDITOR nvim
set -gx GOPATH $HOME/src/go
set -gx CLOUDPATH $HOME/src/CloudExperiments
set -gx FZF_DEFAULT_COMMAND 'fd -H'
set -gx FZF_DEFAULT_OPTS ' --no-exact'
set -gx GPG_TTY (tty)

set -g fish_user_paths \
   $GOPATH/bin \
   $HOME/.local/bin \
   $HOME/.cargo/bin \
   $HOME/.yarn/bin \
   $HOME/.istioctl/bin

fzf_key_bindings
starship init fish | source

source ~/.config/fish/aliases.fish

# Default to tokynight theme
set -q THEME; or set -gx THEME tokyonight
source $HOME/.config/themes/$THEME.theme

bind \ea $HOME/.config/tmux/manage.fish
bind \ew "tmux new-session -s work -c $CLOUDPATH"
bind \cb select-branch

if test (uname) = "Darwin"
	# MacOS specific config
	set -gx KDEV_KUBE_CONTEXT docker-desktop

	source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
	source /usr/local/opt/asdf/libexec/asdf.fish
else
	# Linux specific config
	set -gx KDEV_KUBE_CONTEXT minikube

	source "$HOME/.local/share/google-cloud-sdk/path.fish.inc"

	gpg-connect-agent updatestartuptty /bye >/dev/null

	if test -z $DISPLAY; and test (tty) = "/dev/tty1"
		startx
	end
	source $HOME/.local/share/asdf/asdf.fish
end

