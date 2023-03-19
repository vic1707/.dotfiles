git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
ln -fs "$HOME/.dotfiles/.zshrc" ~/.zshrc
ln -fs "$HOME/.dotfiles/.p10k.zsh" ~/.p10k.zsh
ln -fs "$HOME/.dotfiles/.gitconfig" ~/.gitconfig
ln -fs "$HOME/.dotfiles/.zsh_history" ~/.zsh_history

## fonts
if [ "$(uname)" = "Darwin" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install zsh-autosuggestions zsh-syntax-highlighting
  cp -r $HOME/.dotfiles/.fonts/* "$HOME/Library/Fonts"
else
  cp -r $HOME/.dotfiles/.fonts/* "$HOME/.local/share/fonts"
fi

## install terminal software
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -fsSL https://xmake.io/shget.text | bash
# reload $PATH
source ~/.zshrc
cargo install nushell
brew install 
