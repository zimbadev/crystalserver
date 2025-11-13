# Crystal Server

[![Discord](https://img.shields.io/discord/1310943869923495988?style=flat-square&logo=discord)](https://discord.gg/7AYJEHTghQ)
[![Build - Ubuntu](https://github.com/zimbadev/crystalserver/actions/workflows/build-ubuntu.yml/badge.svg)](https://github.com/zimbadev/crystalserver/actions/workflows/build-ubuntu.yml)
[![Build - Windows - CMake](https://github.com/zimbadev/crystalserver/actions/workflows/build-windows-cmake.yml/badge.svg)](https://github.com/zimbadev/crystalserver/actions/workflows/build-windows-cmake.yml)
[![Build - Windows - Solution](https://github.com/zimbadev/crystalserver/actions/workflows/build-windows-solution.yml/badge.svg)](https://github.com/zimbadev/crystalserver/actions/workflows/build-windows-solution.yml)
[![Build - Docker](https://github.com/zimbadev/crystalserver/actions/workflows/build-docker.yml/badge.svg)](https://github.com/zimbadev/crystalserver/actions/workflows/build-docker.yml)
![GitHub repo size](https://img.shields.io/github/repo-size/zimbadev/crystalserver)
[![GitHub](https://img.shields.io/github/license/zimbadev/crystalserver)](https://github.com/zimbadev/crystalserver/blob/main/LICENSE)


## Project

Crystal Server is a free and open-source MMORPG server emulator written in C++.

It is based on [The Forgotten Server](https://github.com/otland/forgottenserver) project forked from [Open Tibia](https://github.com/opentibia/server).

This project was created a long time ago to distribute a stable and safe distro for those who want to have a Tibia otserv.

To connect to the server and to take a stable experience, you can
use the [Game Client](https://github.com/zimbadev/gameclient/releases) or [mehah's OTCLient](https://github.com/mehah/otclient).

If you want edit the map, use the [Remere's Map Editor](https://github.com/zimbadev/rme-crystalserver/releases).

You are subject to our code of conduct, read
at [this link](https://github.com/zimbadev/crystalserver/blob/main/CODE_OF_CONDUCT.md).

You can use your own tool to generate Monster Loot and Monster Elements at [this link](https://crystalsever.vercel.app).

### Official Discord
Enjoy our [Discord](https://discord.gg/zm4MTKtQQh)

### Thanks
- [Open Tibia](https://github.com/opentibia/server) and their [contributors](https://github.com/opentibia/server/graphs/contributors).
- [The Forgotten Server](https://github.com/otland/forgottenserver) and their [contributors](https://github.com/otland/forgottenserver/graphs/contributors).
- [Crystal Server](https://github.com/zimbadev/crystalserver) and their [contributors](https://github.com/zimbadev/crystalserver/graphs/contributors).

### Issues

We use the [issue tracker on GitHub](https://github.com/zimbadev/crystalserver/issues). Keep in mind that everyone who is
watching the repository gets notified by e-mail when there is an activity, so be thoughtful and avoid writing comments
that aren't meant for an issue (e.g. "+1"). If you'd like for an issue to be fixed faster, you should either fix it
yourself and submit a pull request, or place a bounty on the issue.

### Pull requests

Before [creating a pull request](https://github.com/zimbadev/crystalserver/pulls) please keep in mind:

* Do not send Pull Request changing the map, as we can't review the changes.
* Focus on fixing only one thing, mixing too much things on the same Pull Request make it harder to review, harder to
  test and if we need to revert the change it will remove other things together.
* Follow the project indentation, if your editor support you can use the [editorconfig](https://editorconfig.org/) to
  automatic configure the indentation.
* There are people that doesn't play the game on the official server, so explain your changes to help understand what
  are you changing and why.
* Avoid opening a Pull Request to just update one line of a XML file.


### Download Latest Executable
* Follow the steps in the video below to download the latest executable available, compiled by GitHub Actions.

https://github.com/user-attachments/assets/58089db8-c86b-43ed-9601-556af2405a80

### Compiling from Source (Guided Scripts)
If you prefer to compile the server yourself, you can use one of our guided installer scripts. You only need to download the file that matches your operating system (`crystal_windows_installer.ps1` for Windows, or `linux_installer.sh` for Linux).

#### Windows (PowerShell)
A guided PowerShell script is available to automate the entire compilation process, including the installation of Git, CMake, and Visual Studio.

1.  Download the `crystal_windows_installer.ps1` script to your computer.
2.  Right-click your Start menu and select **"Windows Terminal (Admin)"** or **"PowerShell (Admin)"**.
3.  Due to Windows security, you must first bypass the execution policy *for this session*. Type the following command and press Enter:
    ```powershell
    Set-ExecutionPolicy Bypass -Scope Process
    ```
4.  Navigate to the script's location (e.g., your Desktop):
    ```powershell
    cd C:\Users\YourUser\Desktop
    ```
5.  Run the installer:
    ```powershell
    .\crystal_windows_installer.ps1
    ```
6.  The script will automatically set the correct policy for future runs and guide you through the language, branch, and installation steps.

#### Linux (Bash)
A guided Bash script is available for most modern distributions (Debian/Ubuntu, Arch, Fedora).

1.  Download the `linux_installer.sh` script.
2.  Open your terminal and navigate to the script's location.
3.  Make the script executable:
    ```bash
    chmod +x linux_installer.sh
    ```
4.  Run the installer (do **not** use `sudo` to run the script itself):
    ```bash
    ./linux_installer.sh
    ```
5.  The script will guide you through the process and will only ask for your password (via `sudo`) when it needs to install system packages.
