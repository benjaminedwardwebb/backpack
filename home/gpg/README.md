# key management

I use [GNU Privacy Guard][1] (GPG) to manage my PGP keys. I use a primary key
with subkeys for encryption and authentication (i.e., SSH).

To synchronize my keys across hosts, I simply copy the GPG home directory to
a new host via `scp`. The GPG home directory lives at `~/.config/gnupg`.

## host-specific keys

Some keys should never leave a specific host. An example of this is the SSH key
I use to authenticate into company-owned systems for work.

To handle these cases, I synchronize my personal keys to the host and then add
the host-specific key afterwards.

	gpg --expert --edit-key Ben
	# Proceed to add key. See the example below for details.

If my synchronized keys change (e.g., I add a new encryption subkey), then I
do the following on the host with host-specific keys

  - export host-specific keys
  - delete the local GPG home directory
  - copy the updated GPG home directory via `scp`
  - add the host-specific keys back in

It's an annoying but simple process that rarely happens.

### example

Here's an example of synchronizing my keys from host `berrio` to host
`vm-lamu`, and then adding an existing host-specific SSH key as a subkey.

	# Start on host berrio that contains the GPG keys.
	# --- berrio

	# Do the following inside the host-specific secrets directory.
	cd ~/hosts/berrio/secrets

	cp -r ~/.config/gnupg ./gnupg
	tar --create --file gnupg.tar gnupg
	gpg --encrypt --armor --symmetric gnupg.tar
	# Enter symmetric encryption passphrase.
	# Add recipient of self (this won't actually be used).
	
	# --- vm-lamu
	# On the other host, vm-lamu, download the archived, encrypted file.
	cd ~/hosts/vm-lamu/secrets
	scp berrio:~/hosts/berrio/secrets/gnupg.tar.asc .
	gpg --decrypt gnupg.tar.asc
	# Enter symmetric encryption passphrase.
	tar --extract --file gnupg.tar
	
	# Carefully move the new gnupg home directory into place.
	mv ~/.config/gnupg ./gnupg.old
	mv ./gnupg ~/.config/gnupg

	# The copied gnupg directory probably contains orphaned links to the nix
	# store. Unlink them so they can be generated appropriately for the next
	# NixOS rebuild. There may be more than what's listed below.
	unlink ~/.config/gnupg/gpg-agent.conf
	unlink ~/.config/gnupg/gpg.conf
	unlink ~/.config/gnupg/scdaemon.conf
	unlink ~/.config/gnupg/sshcontrol

	# Bump something in gpg configuration here and then rebuild NixOS, so that
	# it will rebuild the appropriate links to the host's nix store. For
	# example, disable gpg, then rebuild, then enable gpg, then rebuild again.
	sudo nixos-rebuild switch

	# Add the host-specific key (an SSH key in this example).
	#
	# The easiest way to do this is with ssh-add. This sets the SSH key's
	# comment based on the private key's filename, so first we rename it.
	# This also modifies the GPG sshcontrol file, which is normally controlled
	# by nix in my configuration, so we must unlink it.
	#
	# Note, this assumes that the gpg-agent is running with ssh support enabled
	# and is acting as the ssh-agent, as is configured here in ./default.nix.
	#
	# See: https://unix.stackexchange.com/a/477410
	mv ~/ssh/id_rsa ~/ssh/$REDACTED
	unlink ~/.config/gnupg/sshcontrol
	ssh-add ~/ssh/$REDACTED

	# Compare the keygrips of private keys against existing subkeys to find
	# the keygrip of the newly added SSH key.
	ls -l ~/.config/gnupg/private-keys-v1.d/
	gpg --list-keys

	# Copy the new SSH key's keygrip to the clipboard and add it as a subkey.
	gpg --expert --edit-key Ben
	# addkey
	# (13) Existing key
	# Paste the new SSH key's keygrip.
	# Authenticate (enter S, E, A, and Q, successively)
	# 0 = key does not expire
	# y
	# y
	# Enter PGP primary key passphrase.
	# save

	# Add the keygrip to the host-specific keygrips file.
	#
	# In this example, that means pasting it into the file at
	# ~/hosts/vm-lamu/static/ssh/keygrips.nix. Then delete the sshcontrol file
	# that was created with ssh-add above, and generate the real one by
	# rebuilding the system.
	rm ~/.config/gnupg/sshcontrol
	sudo nixos-rebuild switch

	# Test that it works.
	ssh $REDACTED

	# Get rid of the key at ~/.ssh since it's no longer needed.
	mv ~/.ssh/id_rsa /tmp/id_rsa
	mv ~/.ssh/id_rsa.pub /tmp/id_rsa.pub

	# Clean up after yourself on both hosts!
	# Assuming you're still in ~/hosts/vm-lamu/secrets ...
	rm -r gnupg.old
	rm gnupg.tar
	rm gnupg.tar.asc

	# --- berrio
	# And on berrio, clean up in ~/hosts/berrio/secrets.
	rm -r gnupg
	rm gnupg.tar
	rm gnupg.tar.asc

This example transmits private keys over the local network. While private keys
are usually encrypted anyways (if they have a passphrase), this example
encrypts the entire GPG home directory anyways as an additional step. Still, it
shouldn't be done on a public network.

[1]: https://gnupg.org/
