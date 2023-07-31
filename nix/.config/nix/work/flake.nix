{
    description = "Sparx";

    inputs = {
      nixpkgs.url = "nixpkgs/nixos-23.05";
      nixpkgs_22-11.url = "nixpkgs/nixos-22.11";
      flake-utils.url = "flake-utils";
    };

    outputs = {self, nixpkgs, nixpkgs_22-11, flake-utils} : 
      flake-utils.lib.eachDefaultSystem 
        (system:
          let
            pkgs = import nixpkgs { inherit system; };
            pkgs_22-11 = import nixpkgs_22-11 { inherit system; };
            inputs = with pkgs; [
                python39
                libxcrypt
                terraform
                kubectl
                kubectx
                (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
                bazel
                go
                postgresql_14
                grpcurl
                pkgs_22-11.nodejs-16_x
                pkgs_22-11.nodejs-16_x.pkgs.pnpm
                jdk11
                protobuf3_20
              ];
          in {
            packages.containerImage = pkgs.dockerTools.buildLayeredImage {
              name = "spxbuilder";
              contents = inputs;
            };
            devShells.default = pkgs.mkShell {
              buildInputs = inputs;
            };
          }
        );
}
