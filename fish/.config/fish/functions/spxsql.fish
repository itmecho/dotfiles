function spxsql --description "Start pgbouncer port foward and connect with psql"
	tmux split-window -d -h -l 100 'kubectl -n pgbouncer-iguana port-forward deployment/pgbouncer 5433:5432 | sed "s/^/pgbouncer: /"'
	PGPASSWORD=(gcloud secrets versions access latest --secret='test2-cloudsql-proxyuser-password' 2>/dev/null) psql -h localhost -p 5433 -U proxyuser postgres
	tmux kill-pane -t 1
end
