{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
	buildInputs = [
		python39
		terraform
		kubectl
		kubectx
		(google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
		bazel_5
		go
		postgresql_14
	];

	shellHook = ''
		npm install -g pnpm@6
	'';
}
