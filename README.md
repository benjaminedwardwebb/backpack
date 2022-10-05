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
├── bootstrap           bootstrap executable (to setup new hosts)
├── configuration.nix   facade configuration.nix that loads those in hosts/
├── docs                repository documentation
├── home                Home Manager configuration for the user environment
├── hosts               NixOS configurations for host system environments
├── lib                 library of re-usable nix code
├── README.md           repository's README
├── scripts             utility scripts and executables
└── shell.nix           repository's nix-managed development environment
```

## install

Setup a new NixOS host with the following steps.

  - install NixOS
  - configure the hostname (ensure it is correctly set in `/etc/hostname`)
  - transmit secrets to the host, including an SSH key registered with GitHub
  - obtain and run the [`bootstrap` executable][4] and follow its instructions
    - `nix-shell -p wget --run 'wget -O bootstrap "https://tinyurl.com/backpack-bootstrap"'`
    - `chmod +x bootstrap`
    - `./bootstrap`
  - edit `/etc/nixos/hosts/$HOSTNAME/configuration.nix` and then commit it
    - `chown -R $USER:$(groups | cut -d " " -f 1) /etc/nixos`

[4]: https://tinyurl.com/backpack-bootstrap

## history

This configuration repository has been around since 2017. It's included a lot of configuration at varying points in time.

I transitioned to using [NixOS][5] in late 2022. Around this time I squashed the repository's history and made it public.

[5]: https://nixos.org/guides/nix-pills/why-you-should-give-it-a-try.html
