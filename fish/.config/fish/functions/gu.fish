function gu
	set pkg $argv[1]
	echo "Upgrading $pkg"
	go get $pkg@latest
	if [ (git status --short | wc -l) -eq 0 ];
		echo "No changes"
		return
	end

	go mod tidy
	barx gazelle deps
	barx gazelle
	ga .
	gs
	echo "Press Enter to commit..."
	read cont
	gc -m "Upgrade $pkg"
end
