{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
	buildInputs = [
		python39
		libxcrypt
		terraform
		kubectl
		kubectx
		(google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
		cloud-sql-proxy
		bazel_5
		go
		postgresql_14
		grpcurl
		nodejs-16_x
		nodePackages.pnpm
		jdk11
		protobuf3_20
	];
}
