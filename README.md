# ksv-fastapi-nix-shell

## Introduction
ksv-fastapi-nix-shell is a project designed to demonstrate how quickly you can configure a complete development environment with just few commands in just few minutes or even seconds using `nix`😊. This setup ensures consistency😄 and removes the manual overhead😮‍💨 of configuring dependencies which might requires hours or days of time setting up everything imperatively.

## TLDR:
Just 3 steps:
1) Clone the repo and enter the folder
2) Run the respective comands to :
   - Start a development environment shell (or)
   - Build the app (or)
   - Run the application directly (or)
   - Build the dockerimage
3) Chill out🤟, while nix and my configuration does the heavylifting🏋️
     
## Installation
# Supported Platforms:
    any Linux or Unix based distro, macOS, Windows(WSL)

## Prequisites
If u are already using the NixOS❤️🔥🔥🔥 skip this. Btw, I suggest everyone to try this OG🔥 Distro😁
For others,
**Install Nix:⚙️📦🔧**
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
   
   **Note:**
   The first time u run any of these commands nix builds the environment and caches it✍️📥. So the consequent start
   of the shells will be instantaneous⚡🚀

## Steps:
1. **Clone the Repository:🔄📂💻**
    Fun fact: U don't even need to install git manually as a prequisite in ur system to do the following commands😏. Leave it to nix.
   - Run:
     ```
     nix-shell -p git --command "git clone https://github.com/vivekanandan-ks/ksv-fastapi-nix-shell.git"
     cd ksv-fastapi-nix-shell
     ```
     Dont worry this installs git temporarily in the shell😃, runs the commands and exits the shell😊. Now ur system doesn't have git installed, which avoids polluting ur system environment💪😎. 
     It's super Cool, isn't it?😁😁😁


2. ## Now u can do any/all of these:
   a) **Enter the Development Environment:🏡💻**
   - Setup the full development environment:
     ```
     nix develop .
     ```
   - You now have access to all dependencies (like FastAPI, Uvicorn) automatically. No need to install Python packages manually.💪
   - U can now start working on ur project without wasting hours or days.

   b) **Build the App:⚒️🖥️**
   - Useful to build the artifacts(binaries).
      ```
      nix build .
      ```

   c) **Run the app directly:🚀💻✅**(Yup like a docker but without the overhead😮‍💨)
   - You can even directly run the app :
     ```
     nix run .
     ```
   - This command builds the app and starts running it.
   - Now u can confidently say "It works on my machine"😁😁. Not a joke.😏 

   d) **Build the Docker Image:🏗️🐳🖼️**
   - You can build a distroless, efficiently layered docker image via :
      ```
      nix build .#dockerLayered
      ```
   - The Docker image will be built and available as a tarball.
   - Load it into Docker🛳️🐳:
      ```
      docker load < result
      ```
   - Then run the image via▶️📦 :
      ```
      docker run --rm -p 8000:8000 my-python-app:latest
      ```
   - **TLDR: Docker Usage📦⚡🧠**
      - The flake includes a lightweight layered Docker image using Nix’s dockerTools. 
      - No manual Dockerfile needed!
      - The image includes your Python app and entrypoint to run it. 
      - Eg:
      ```
      nix build .#dockerLayered
      docker load < result
      docker run --rm -p 8000:8000 my-python-app:latest
      ```

## Why This Is Awesome🌟🔥💯
   - Reproducible dev & deploy environments. The development setup guarantees that all dependencies and tools are the same across different machines.🤘😁
   - Minimal dependencies on system tools
   - Instant shell provisioning with exact versions
   - Zero Dockerfile or virtualenv required
   - Confidently say "it works on my machine"

## Notes📝📌:
This project showcases my growing expertise in Nix, DevOps, and reproducible development practices. 
It's also a tribute to show how powerful and elegant the Nix ecosystem can be when harnessed right.
Suggestions & ideas are welcome!

## Thoughts💭💭:
I'll continue to improve this example project of mine covering other use cases which will help improve developer experience much more.
This project is meant to demonstrate my understanding and skills of nix, DevOps tools mastery etc.
Created this project to start showing my skills and learnings, coz Actions > Thoughts. 
And more importantly for the love of Nix, NixOS, Nixpkgs, etc from the nix ecosystem. It's the most innovative and awesome project impressed me so far after Linux, FOSS, community-driven efforts. Check Nix out, it isn't that hard. The documentation and the right way to do things keep improving faster.

  Feel free to share ur coments or improvements in issues.
  - 
