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
            echo "Pulumi shell created by https://github.com/vivekanandan-ks" | ${pkgs.cowsay}/bin/cowsay
            #my custom fish shel prompt customized (comment below to use defualt bash)
            exec ${pkgs.fish}/bin/fish --init-command '
            function fish_prompt
                # Get exit status of last command
                set -l last_status $status
                if test $last_status -eq 0
                    set_color green
                    echo -n "✓ "
                else
                    set_color red
                    echo -n "$last_status "
                end
                set_color normal

                # Get git branch name, if applicable
                set -l git_branch (git symbolic-ref --short HEAD 2>/dev/null)
                if test -n "$git_branch"
                    set_color yellow
                    echo -n "[$git_branch] "
                    set_color normal
                end

                # Prompt prefix
                set_color blue
                echo -n "nix-shell🐠🐚> "
                set_color normal
            end'
            
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

