# ksv-fastapi-nix-shell

## Introduction
ksv-fastapi-nix-shell is a project designed to demonstrate how quickly you can configure a complete development environment with just few commands in just few minutes or even seconds using `nix`😊. This setup ensures consistency😄 and removes the manual overhead😮‍💨 of configuring dependencies which might requires hours or days of time setting up everything imperatively.

## Installation
# Supported Platforms:
    any Linux or Unix based distro, macOS, Windows(WSL)

If u are already using the NixOS❤️🔥🔥🔥 skip step1.
For others, follow steps
1. **Install Nix:**
    -   Install nix via a single command. For details: https://zero-to-nix.com/start/install/

        ```
        curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
        ```

    -   Restart the terminal session and check Nix with 
        ```nix --version```
    Now we can do things a lot easier🥳🎉🎊

2. **Clone the Repository:**
    Fun fact: U don't even need to install git manually as a prequisite in ur system to do the following commands😏. Leave it to nix.
   - Run:
     ```
     nix-shell -p git --command "git clone https://github.com/vivekanandan-ks/ksv-fastapi-nix-shell.git"
     cd ksv-fastapi-nix-shell
     ```
     Dont worry this installs git temporarily in the shell😃, runs the commands and exits the shell😊. Now ur system doesn't have git installed, which avoids polluting ur system environment💪😎. 
     It's Cool, isn't it?😁😁😁


3. **Enter the Development Environment:**
   - Simply execute:
     ```
     nix develop
     ```
   - This command reads the configuration from `flake.nix` to set up the environment automatically💪
   - That's it. U can now confidently say "It works on my machine"😁😁


## Usage

- **Starting Up:**
  - After running `nix develop`, your environment is fully prepared🥳💪.
  - Begin working on your project without additional configuration.
  - The first time u run the command nix builds the environment and caches it✍️📥. So the consequent start
    of the shells will be instantaneous⚡🚀

- **Environment Consistency:**
  - The development setup guarantees that all dependencies and tools are the same across different machines.🤘😁

  ## Note:
  I'll continue to improve this example project of mine covering other use cases which will help improve developer experience much more.
  This project is meant to demonstrate my understanding and skills of nix, DevOps tools mastery etc.
  Created this project to start showing my skills and learnings, coz Actions > Thoughts. 
  And more importantly for the love of Nix, NixOS, Nixpkgs, etc from the nix ecosystem. It's the most innovative and awesome project impressed me so far after Linux, FOSS, community-driven efforts. Check Nix out, it isn't that hard, but the documentation and the right way to do things keep improving faster, but still it's an easy thing learn.

  Feel free to share ur coments or improvements in issues.
  - 
