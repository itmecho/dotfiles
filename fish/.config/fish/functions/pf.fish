function pf \
   --description "port forward a service from the current k8s context" \
   --argument-names service port variant

	if test -z $service;
		echo 'service is required'
		return 1
	end


	test -z $port; and set -l port 3000
	test -z $variant; and set -l variant default

	set -l command  "kubectl port-forward deploy/$service-deployment-$variant $port:3000 | sed 's/^/$service: /'"

	if ! tmux list-windows | rg -q port-forwards;
		tmux new-window -d -n port-forwards $command
	else
		tmux split-window -t port-forwards -v -d "kubectl port-forward deploy/$service-deployment-$variant $port:3000 | sed 's/^/$service: /'"
	end

	tmux select-layout -t port-forwards even-vertical
end
