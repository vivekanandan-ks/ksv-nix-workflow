{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        #for packages not in nixpkgs writre the requirements.txt and 
        #then do the below command before starting the shell(nix develop)
        #nix run github:nix-community/pip2nix -- generate -r requirements.txt
        #packageOverrides = pkgs.callPackage ./python-packages.nix {};
        #python = pkgs.python3.override { inherit packageOverrides; };
        pythonEnv = pkgs.python3.withPackages (ps: with ps; [
          #python packages from pip
          fastapi
          uvicorn
        ]);

        # The Python application
        myApp = pkgs.stdenv.mkDerivation {
          name = "my-python-app";
          src = ./.; # Use the current directory as source
          
          # Install phase: copy the Python files to the output
          installPhase = ''
            mkdir -p $out/app
            cp -r app $out/app
            mkdir -p $out/bin
            cat > $out/bin/start-app <<EOF
            #!${pkgs.bash}/bin/bash
            exec python $out/app/main.py
            EOF
            chmod +x $out/bin/start-app
          '';
        };





        
      in {
        devShells.default = pkgs.mkShell {
          packages = pythonEnv;
          shellHook = ''
          echo "You have entered a shell environment created by https://github.com/vivekanandan-ks"
          echo "This shell environment sets up all the dependencies for the python project down to the libraries needed."
          echo "Enjoy coding :-)"

          ''
        };

        packages = {
          python-app = myApp;
          #ocker = dockerImage; #plannning to build next
        }

      }
    );
}
