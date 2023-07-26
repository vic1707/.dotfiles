This is my `.dotfiles` repository. It contains my configuration files for various programs.

## Requirements
  - `git`
  Should be it.
### MacOS
Xcode license should be accepted.
```sh
xcode-select --install
sudo xcodebuild -license accept
```

## Installation
Clone this repo inside `~/.dotfiles`:
```sh
git clone https://github.com/vic1707/.dotfiles.git ~/.dotfiles
```
And simply run the install script:
```sh
~/.dotfiles/install.sh
```

## Install options
```
Usage: install.sh [options]
Options:
  -h, --help        Show this help message
  -q, --quiet       Quiet mode
  -s, --shell       Install a shell (zsh|bash|nu)
  --all-shells      Install all shells (zsh|bash|nu)
  --                End of options
```
## Usage
The install script will create symlinks to the configuration files in this repo. If you want to add a new configuration file, simply add it to the repo and run the install script again.
