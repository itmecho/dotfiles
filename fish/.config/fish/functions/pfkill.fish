function pfkill \
   --description "kill all port forwards from the current k8s context"
	ps -eo pid,command | awk '/[[:digit:]]+ kubectl.+port-forward/ {print $1}' | xargs -r kill
end
