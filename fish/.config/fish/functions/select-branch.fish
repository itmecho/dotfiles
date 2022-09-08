function select-branch
	set branch (git branch -a --format "%(refname:short)" | fzf --no-multi | sed "s,origin/,,")

    if [ -z "$branch" ]
      commandline -f repaint
      return
    else
      # Remove last token from commandline.
      commandline -t ""
    end

	commandline -it -- $branch
    commandline -f repaint
end
