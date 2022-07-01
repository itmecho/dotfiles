#!/bin/bash

function step() {
	echo -e "\e[01m==> $@\e[00m"
}

function is_installed() {
	command -v $1 &>/dev/null
}

step "Installing required repo packages"
sudo xbps-install go curl kubectl

is_installed asdf || {
  step "Installing asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.local/share/asdf --branch v0.10.0
  . ~/.local/share/asdf/asdf.sh
}

is_installed node || {
  step "Installing nodejs"
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf install nodejs latest
  asdf global nodejs latest
}

is_installed gcloud || {
  step "Installing google-cloud-sdk"
  curl -o /tmp/google-cloud-cli.tgz -L https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-392.0.0-linux-x86_64.tar.gz
  (
    cd /tmp
    tar zxf ./google-cloud-cli.tgz
    mv google-cloud-sdk ~/.local/share/
	rm /tmp/google-cloud-cli.tgz
	cd ~/.local/share/google-cloud-sdk
	./install.sh
  )
}

gcloud auth list --filter status:ACTIVE --format 'value(account)' | grep -qE '.+' || {
	step "Logging in with gcloud"
	gcloud auth login
}

gcloud auth application-default print-access-token | grep -qE '.+' || {
	step "Setting gcloud application default credentials"
	gcloud auth application-default login
}

is_installed kubectx || {
	step "Installing kubectx"
	go install github.com/ahmetb/kubectx/cmd/kubectx@latest
}
is_installed kubens || {
	step "Installing kubens"
	go install github.com/ahmetb/kubectx/cmd/kubens@latest
}

kubectl config get-contexts sparx-test2 &>/dev/null || {
	step "Getting credentials for test2"
	gcloud container clusters get-credentials sparx-test2 --region europe-west1-c
}

kubectl config get-contexts sparx-test1 &>/dev/null || {
	step "Getting credentials for test1"
	gcloud container clusters get-credentials sparx-algenie --region europe-west1-c
}

kubectl config get-contexts sparx-production &>/dev/null || {
	step "Getting credentials for production"
	gcloud container clusters get-credentials spx001 --project sparx-production --region europe-west1
}

is_installed bazel || {
	step "Installing bazelisk"
	go install github.com/bazelbuild/bazelisk@latest
	ln -s ~/src/go/bin/bazelisk ~/.local/bin/bazel
}
