{
  description = "Local Development Environment";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [ awscli2 terraform sops age ];

        shellHook = ''
          export SOPS_AGE_KEY_FILE="$(git rev-parse --show-toplevel)/keys.txt"
        '';
      };
    };
}
