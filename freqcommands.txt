just run the following command to create a shell for the python project, that's it 
its that simple:
ni flake update --flake . #only to update the packages to the latest commit
nix develop . --command python ./app/main.py