# backpack

My electronic backpack.

> also called knapsack, schoolbag, rucksack, rucksac, pack, sackpack, booksack, bookbag or backsack  
> — the article for [Backpack][1] on Wikipedia

> Stay in my backpack forever  
> — [Backpack][2], Justin Beiber

The configuration ([dotfiles][3]) and scripts that I carry around from one host to another.

[1]: https://en.wiki.org/wiki/Backpack
[2]: https://www.youtube.com/watch?v=dekJG2xSIeA
[3]: https://en.wiki.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments

## structure

```sh
tree --noreport -L 1
```
```
.
├── bootstrap           bootstrap executable (run this to setup new hosts)
├── configuration.nix   facade configuration.nix that loads those in hosts/
├── docs                repository documentation
├── home                Home Manager configuration for the user environment
├── hosts               NixOS configurations for host system environments
├── install             install executable
├── lib                 library of re-usable nix code
├── README.md           repository's README
├── scripts             utility scripts and executables
└── shell.nix           repository's nix-managed development environment
```

## install

This configuration is installed on a new NixOS host by running the `install`
executable.

```bash
./install
```

This executable moves any existing NixOS configuration out of the way and symlinks this repository in its place at `/etc/nixos`. It then rebuilds the system.

However, this `install` executable is an implicit step when setting up a new host. Explicit steps include:

  - install NixOS
  - run the [`bootstrap`][4] executable and follow it's instructions

The `bootstrap` executable calls this repository's `install`.

[4]: https://github.com/benjaminedwardwebb/benjaminedwardwebb/blob/main/bootstrap

## history

This configuration repository has been around since 2017. It's included a lot of configuration at varying points in time.

I transitioned to using [NixOS][5] in late 2022. Around this time I squashed the repository's history and made it public.

[5]: https://nixos.org/guides/nix-pills/why-you-should-give-it-a-try.html
