function xbps-src-update
	function log
		echo -e "\e[01m==> $argv\e[00m"
	end

	cd $HOME/src/void-packages

	log "Updating srcs"
	git pull

	set -l packages (fd '.xbps' ./hostdir/binpkgs/ | sed -E 's,./hostdir/binpkgs/(.*/)?(.*)-(([0-9_\.]+)+)\..*$,\1\2,' | sort | uniq)
	log "Found installed packages"
	for pkg in $packages
		set -f ver (ls "./hostdir/binpkgs/$pkg"* | tail -1 | sed -E 's,./hostdir/binpkgs/(.*/)?(.*)-(([0-9_\.]+)+)\..*$,\3,')
		set -f -a package_versions "$pkg:$ver"
		echo "    $pkg: $ver"
	end

	for pkg in $package_versions;
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

		set -f pkg (echo $pkg_name | sed -E 's/(.*\/)*(.*):.*/\2/')

		./xbps-src pkg $pkg
		xi $pkg
	end
end
