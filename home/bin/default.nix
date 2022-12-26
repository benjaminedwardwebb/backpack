# Links custom executables to ~/.local/bin.
# See: https://unix.stackexchange.com/a/36874
{ ... }:

{
  home.file.".local/bin/mail".source = ./mail;
  home.file.".local/bin/chat".source = ./chat;
  home.file.".local/bin/news".source = ./news;
  home.file.".local/bin/terminal".source = ./terminal;
}
