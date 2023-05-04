function tp2-up
	if test (uname) = "Darwin"
		echo -e "\e[01m==> Update dnsmasq config\e[00m"
		kdev dns update-local --mimictest iain
		echo -e "\e[01m==> Creating loopback alias\e[00m"
		sudo ifconfig lo0 alias 127.0.0.2 up
		echo -e "\e[01m==> Forwarding 443 to 3000\e[00m"
		echo "rdr pass proto tcp from any to any port 443 -> 127.0.0.2 port 3000" | sudo pfctl -Ef -
		echo -e "\e[01m==> Done\e[00m"
		echo "    Now make sure your first DNS server in Network is set to 127.0.0.1"
	else
		set -l route_data (ip route get 1.1.1.1)
		set -l local_ip (echo $route_data | awk '/1.1.1.1/ {print $7}')
		set -l local_interface (echo $route_data | awk '/1.1.1.1/ {print $5}')
		set -l dnsmasq_conf /etc/dnsmasq.d/sparx.conf
		echo "configuring dnsmasq"
		sudo rm -f $dnsmasq_conf
		sudo touch $dnsmasq_conf
		echo "address=/devserver.test.sparxmaths.uk/$local_ip" | sudo tee $dnsmasq_conf >/dev/null
		echo "address=/.devserver.test.sparxmaths.uk/$local_ip" | sudo tee -a $dnsmasq_conf >/dev/null
		sudo systemctl restart dnsmasq
		echo "forwarding $local_ip:443 to $local_ip:3000"
		sudo iptables -t nat -D OUTPUT --source $local_ip --destination $local_ip -p tcp --dport 443 -j REDIRECT --to-ports 3000 2>/dev/null
		sudo iptables -t nat -A OUTPUT --source $local_ip --destination $local_ip -p tcp --dport 443 -j REDIRECT --to-ports 3000
	end

	cd $CLOUDPATH/teacherportal/tpclient2
	pnpm run start
end
