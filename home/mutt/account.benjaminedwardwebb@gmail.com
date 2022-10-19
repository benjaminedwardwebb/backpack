# muttrc/account.benjaminedwardwebb@gmail.com
# vim: filetype=muttrc
# My mutt account configuration for benjaminedwardwebb@gmail.com.

# Set IMAP and SMTP settings for this account.
#
# A mutt-specific app password is used to authenticate into gmail.
#
# PASSWORDS ARE STORED IN PASS. THERE ARE NO SECRETS IN THIS REPOSITORY.
set from = "benjaminedwardwebb@gmail.com"
set folder = "imaps://imap.gmail.com:993"
set imap_user = "benjaminedwardwebb@gmail.com"
set imap_pass = "`pass mutt-benjaminedwardwebb@gmail.com`"
set smtp_url = "smtps://benjaminedwardwebb@gmail.com@smtp.gmail.com:465/"
set smtp_pass = "`pass mutt-benjaminedwardwebb@gmail.com`"

# Set folder settings for this account.
set spoolfile = "+INBOX"
set postponed ='+[Gmail]/Drafts'
set trash = '+[Gmail]/Trash'

# Set local data storage directories for this account.
set header_cache = ~/.local/share/mutt/benjaminedwardwebb@gmail.com/cache/headers
set message_cachedir = ~/.local/share/mutt/benjaminedwardwebb@gmail.com/cache/bodies
set certificate_file = ~/.local/share/mutt/benjaminedwardwebb@gmail.com/certificates
set record = ~/.local/share/mutt/benjaminedwardwebb@gmail.com/sent
