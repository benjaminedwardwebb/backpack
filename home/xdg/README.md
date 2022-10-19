# directories

This is my directory configuration. It describes the structure of my
home directory that is shared across hosts.

Wherever possible, I try to follow [XDG][1] conventions and specifications. 

## structure

The top-level directory structure of my home directory is as follows.

```bash
tree --noreport -L 1 ~
```
```
/home/benjaminedwardwebb
├── backup
├── desktop
├── documents
├── downloads
├── hosts
├── images
├── music
├── notes
├── projects
└── videos
```

### host-specific data

The `hosts` directory is used to store host-specific data that aren't
synchronized. It contains one directory, named after the host. This
host-specific directory contains three additional sub-directories.

For example, here is the structure on my personal laptop, `berrio`.

```
tree --noreport -L 1 ~/hosts/berrio
```
```
/home/benjaminedwardwebb/hosts/berrio
├── dynamic
├── secrets
└── static
```

The `static` directory contains host-specific nix configuration.

The `dynamic` directory contains host-specific state that is not tracked
declaratively with nix.

The `secrets` directory contains additional host-specific state that is secret.
This is the non-root equivalent of `/etc/secrets`. Using the `pass` password
store at `~/.local/share/pass/password-store` is always preferred. However,
sometimes a plaintext, non-root secret is required. It's still protected by my
login password.

There's is surely state that is unsynchronized and host-specific
that lives outside of these directories. However, such state should be
considered ephemeral. In the future I may enforce this as described in
`grahamc`'s blog, [_Erase your darlings_][2].

[1]: https://www.freedesktop.org/wiki/Software/xdg-user-dirs/
[2]: https://grahamc.com/blog/erase-your-darlings
