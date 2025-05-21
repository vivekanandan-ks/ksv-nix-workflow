{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pip2nix.url = "github:nix-community/pip2nix";
  };

  outputs = { self, nixpkgs, flake-utils, gitignore, pip2nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        inherit (gitignore.lib) gitignoreSource;
        pkgs = import nixpkgs { inherit system; };

        packageOverrides = pkgs.callPackage (gitignoreSource ./python-packages.nix) {};
        python = pkgs.python313.override { inherit packageOverrides; };

        pythonEnv = python.withPackages (p: with p; [
            #from pypi (add only in requirements.txt)
            import (gitignoreSource ./requirements.nix)
            
            #from nixpkgs (add here below)

        ]);

        #generating dependencies from requirements.nix
        install-requirements = pkgs.writeShellApplication {
          name = "install-requirements";
          runtimeInputs = [pip2nix.defaultPackage.${system}];
          text = ''
            #!/usr/bin/env ${pkgs.bash}/bin/bash
            echo "Running install-requirements..."
            ${pip2nix.defaultPackage.${system}}/bin/pip2nix generate -r ./requirements.nix
          '';
        };

        # The Python application
        myApp = pkgs.stdenv.mkDerivation {
          name = "my-python-app";
          src = gitignoreSource ./.; # Use the current directory as source
          
          # Install phase: copy the Python files to the output
          installPhase = ''
            mkdir -p $out/app
            cp -r app $out/
            mkdir -p $out/bin
            cat > $out/bin/start-app <<EOF
            #!${pkgs.bash}/bin/bash
            exec ${pythonEnv.interpreter} $out/app/main.py
            EOF
            chmod +x $out/bin/start-app
          '';
        };

        myShell = pkgs.mkShell {
          packages = [
            pythonEnv
          ];

          shellHook = ''
              ${install-requirements}/bin/install-requirements
              echo -e "You have entered a shell environment created by https://github.com/vivekanandan-ks. \n\
              This shell environment sets up all the dependencies for the python project down to the libraries needed. \n\
              Enjoy coding :-) moooooooooooooooo" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
          '';

        };

        dockerLayeredImage = pkgs.dockerTools.buildLayeredImage {
          name = "my-python-app";
          tag = "latest";
          contents = [ myApp ];
          config = {
            Cmd = [ "/bin/start-app" ];
            WorkingDir = "/app";
          };
        };
        
      in {
        devShells.default = myShell;

        packages = { 
          install-requirements = install-requirements;
          default = myApp;
          dockerLayered = dockerLayeredImage;
        };

        apps.default = {
          type = "app";
          program = "${myApp}/bin/start-app";
        };      
      }
    );
}

