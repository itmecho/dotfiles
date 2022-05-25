function update-go-tools
	go install golang.org/x/tools/cmd/godoc@latest
	go install golang.org/x/tools/gopls@latest
	go install golang.org/x/tools/cmd/goimports@latest
	go install github.com/segmentio/golines@latest
	go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
end
