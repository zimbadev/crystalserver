# Crystal Server

[![Discord](https://img.shields.io/discord/1310943869923495988?style=flat-square&logo=discord)](https://discord.gg/7AYJEHTghQ)
[![Build - Ubuntu](https://github.com/jprzimba/crystalserver/actions/workflows/build-ubuntu.yml/badge.svg)](https://github.com/jprzimba/crystalserver/actions/workflows/build-ubuntu.yml)
[![Build - Windows - CMake](https://github.com/jprzimba/crystalserver/actions/workflows/build-windows-cmake.yml/badge.svg)](https://github.com/jprzimba/crystalserver/actions/workflows/build-windows-cmake.yml)
[![Build - Windows - Solution](https://github.com/jprzimba/crystalserver/actions/workflows/build-windows-solution.yml/badge.svg)](https://github.com/jprzimba/crystalserver/actions/workflows/build-windows-solution.yml)
[![Build - Docker](https://github.com/jprzimba/crystalserver/actions/workflows/build-docker.yml/badge.svg)](https://github.com/jprzimba/crystalserver/actions/workflows/build-docker.yml)
![GitHub repo size](https://img.shields.io/github/repo-size/jprzimba/crystalserver)
[![GitHub](https://img.shields.io/github/license/jprzimba/crystalserver)](https://github.com/jprzimba/crystalserver/blob/main/LICENSE)


## Project

Crystal Server is a free and open-source MMORPG server emulator written in C++.

It is based on [The Forgotten Server](https://github.com/otland/forgottenserver) project forked from [Open Tibia](https://github.com/opentibia/server).

This project was created a long time ago to distribute a stable and safe distro for those who want to have a Tibia otserv.

To connect to the server and to take a stable experience, you can
use the [Game Client](https://github.com/jprzimba/gameclient/releases) or [mehah's OTCLient](https://github.com/mehah/otclient).

You can see the complete change log for Crystal Server at [this link](https://github.com/jprzimba/crystalserver/blob/main/markdowns/CHANGELOG.md).

If you want edit the map, use the [Remere's Map Editor](https://github.com/jprzimba/rme-crystalserver/releases).

You are subject to our code of conduct, read
at [this link](https://github.com/jprzimba/crystalserver/blob/main/markdowns/CODE_OF_CONDUCT.md).

You can use your own tool to generate Monster Loot and Monster Elements at [this link](https://crystalsever.vercel.app).

### Official Discord
Enjoy our [Discord](https://discord.gg/7AYJEHTghQ)

### Thanks
- [Open Tibia](https://github.com/opentibia/server) and their [contributors](https://github.com/opentibia/server/graphs/contributors).
- [The Forgotten Server](https://github.com/otland/forgottenserver) and their [contributors](https://github.com/otland/forgottenserver/graphs/contributors).
- [Crystal Server](https://github.com/jprzimba/crystalserver) and their [contributors](https://github.com/jprzimba/crystalserver/graphs/contributors).

### Issues

We use the [issue tracker on GitHub](https://github.com/jprzimba/crystalserver/issues). Keep in mind that everyone who is
watching the repository gets notified by e-mail when there is an activity, so be thoughtful and avoid writing comments
that aren't meant for an issue (e.g. "+1"). If you'd like for an issue to be fixed faster, you should either fix it
yourself and submit a pull request, or place a bounty on the issue.

### Pull requests

Before [creating a pull request](https://github.com/jprzimba/crystalserver/pulls) please keep in mind:

* Do not send Pull Request changing the map, as we can't review the changes.
* Focus on fixing only one thing, mixing too much things on the same Pull Request make it harder to review, harder to
  test and if we need to revert the change it will remove other things together.
* Follow the project indentation, if your editor support you can use the [editorconfig](https://editorconfig.org/) to
  automatic configure the indentation.
* There are people that doesn't play the game on the official server, so explain your changes to help understand what
  are you changing and why.
* Avoid opening a Pull Request to just update one line of a XML file.