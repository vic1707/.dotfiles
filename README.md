This is my `.dotfiles` repository. It contains my configuration files for various programs.

## Requirements
  - `git`
  Should be it.

## Installation
Clone this repo inside `~/.dotfiles`:
```sh
git clone https://github.com/vic1707/.dotfiles.git ~/.dotfiles
```
And simply run the install script:
```sh
~/.dotfiles/install.sh
```

## After install

Add SSH key:
```sh
ssh-keygen -t ed25519 -f ~/.ssh/github-vic1707 -P '' -C "<email>"
ssh-add ~/.ssh/github-vic1707
```
Once ssh key is generated and added to github run 
```sh
git remote set-url origin git@github.com:vic1707/.dotfiles
```
to be able to push via ssh instead of HTTPS.
