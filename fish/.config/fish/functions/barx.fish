function barx
	$CLOUDPATH/barx.sh $argv
	fd --no-ignore --maxdepth 1 ^bazel- $CLOUDPATH | xargs -r rm
end
