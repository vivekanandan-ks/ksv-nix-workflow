# ksv-fastapi-nix-shell

## Introduction
ksv-fastapi-nix-shell is a project designed to demonstrate how quickly you can configure a complete development environment with just few commands in just few minutes or even seconds using `nix`😊. This setup ensures consistency😄 and removes the manual overhead😮‍💨 of configuring dependencies which might requires hours or days of time setting up everything imperatively.

## TLDR:
Just 3 steps:
1) Clone the repo and enter the folder
2) Run just one command to either
   - Start a development environment shell (or)
   - Run the application directly
3) Chill out🤟, while nix and my configuration does the heavylifting🤝
     
## Installation
# Supported Platforms:
    any Linux or Unix based distro, macOS, Windows(WSL)

## Prequisites
If u are already using the NixOS❤️🔥🔥🔥 skip this. Btw, I suggest everyone to try this OG🔥 Distro😁
For others,
**Install Nix:**
   -Install nix via a single command. For details: https://zero-to-nix.com/start/install/
   ```
      curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```
   -Restart the terminal session and check Nix with 
   ```
      nix --version
   ```

   Now we can do things a lot easier🥳🎉🎊. 
   Spoiler🤫: U have installed something really extraordinary.

## Steps:
1. **Clone the Repository:**
    Fun fact: U don't even need to install git manually as a prequisite in ur system to do the following commands😏. Leave it to nix.
   - Run:
     ```
     nix-shell -p git --command "git clone https://github.com/vivekanandan-ks/ksv-fastapi-nix-shell.git"
     cd ksv-fastapi-nix-shell
     ```
     Dont worry this installs git temporarily in the shell😃, runs the commands and exits the shell😊. Now ur system doesn't have git installed, which avoids polluting ur system environment💪😎. 
     It's super Cool, isn't it?😁😁😁


2. ## Now u can:
   a) **Enter the Development Environment:**🙌🙌
   - Simply execute:
     ```
     nix develop .
     ```
   - This command reads the configuration from `flake.nix` to set up the environment automatically💪
   - U can now start working on ur project without wasting hours or days.

   b) **Run the program directly:**😎😎(Yup like a docker but without the overhead😮‍💨)
   - Simply execute:
     ```
     nix run .
     ```
     - This command just built the app and started running it.
     - Now u can confidently say "It works on my machine"😁😁. Not a joke.😏

## Usage

- **Starting Up:**
  - After running ```nix develop .```, your environment is fully prepared🥳💪.
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
