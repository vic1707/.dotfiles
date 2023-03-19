git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
ln -fs "$HOME/.dotfiles/.zshrc" ~/.zshrc
ln -fs "$HOME/.dotfiles/.p10k.zsh" ~/.p10k.zsh
ln -fs "$HOME/.dotfiles/.gitconfig" ~/.gitconfig
ln -fs "$HOME/.dotfiles/.zsh_history" ~/.zsh_history

echo "Minimal config done"

## fonts
if [ "$(uname)" = "Darwin" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  /opt/homebrew/bin/brew install zsh-autosuggestions zsh-syntax-highlighting
  cp -r $HOME/.dotfiles/.fonts/* "$HOME/Library/Fonts"
  echo "MacOS specifics and fonts installed"
else
  cp -r $HOME/.dotfiles/.fonts/* "$HOME/.local/share/fonts"
  echo "Linux specifics and fonts installed"
fi

## install terminal software
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -fsSL https://xmake.io/shget.text | bash
echo "Xmake, nvm & rust installed"

# reload $PATH
source ~/.zshrc
echo "Path reloaded"

nvm install node
# cargo install nushell
brew install nvim
echo "Additional softwares installed"
