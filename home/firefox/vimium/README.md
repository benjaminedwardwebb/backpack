# vimium-options [![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

This is my [vimium][vimium] configuration.

[![vimium logo](/doc/vimium.png)][vimium]

Vimium provides backup and restore functionality that persists its customizable options to a JSON file.

Rather than edit the configuration in the extension's provided options page, the approach used here is to edit files locally, render the changes in vimium's JSON format, then restore the new configuration as if it were a backup.

This makes managing vimium's configuration a little more comfortable.

## Usage

Edit one of the following files with changes.

  - `keyMappings.vim`
  - `searchEngines.properties`
  - `userDefinedLinkHintCss.css`

Render the updated contents of these files as a single JSON file with a local script.

```bash
./local
```

Restore the JSON file on vimium's options page and save changes.

![vimium-options restore button screenshot](doc/vimium-options-restore.png)

[vimium]: https://github.com/philc/vimium
