function xbps-src-update
	function log
		echo -e "\e[01m==> $argv\e[00m"
	end

	cd $HOME/src/void-packages

	log "Updating srcs"
	git pull

	set packages (fd '.xbps' ./hostdir/binpkgs/ | sed -E 's,.*/(.*)-(([0-9_\.]+)+)\..*$,\1:\2,')
	log "Found installed packages"
	for pkg in $packages
		echo "    $pkg"
	end

	for pkg in $packages;
		set pkg_name (echo $pkg | cut -d':' -f1)
		set pkg_ver (echo $pkg | cut -d':' -f2)
		set ver (./xbps-src show $pkg_name | awk '/version:/ {print $2}')
		set rev (./xbps-src show $pkg_name | awk '/revision:/ {print $2}')
		set new_ver $ver'_'$rev

		if [ "$pkg_ver" = "$new_ver" ]
			log "$pkg_name is already up to date"
			continue
		end

		log "Updating $pkg_name from $pkg_ver to $new_ver"

		./xbps-src pkg $pkg
		xi $pkg
	end
end
