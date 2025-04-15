{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        #for packages not in nixpkgs writre the requirements.txt and 
        #then do the below command before starting the shell(nix develop)
        #nix run github:nix-community/pip2nix -- generate -r requirements.txt
        #packageOverrides = pkgs.callPackage ./python-packages.nix {};
        #python = pkgs.python313.override { inherit packageOverrides; };
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            (pkgs.python3.withPackages (p: with p ; [
              #python packages from pip
              fastapi
              uvicorn
              
              ]))
          ];
        };
      }
    );
}
