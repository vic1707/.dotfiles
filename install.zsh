git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
ln -fs "$HOME/.dotfiles/.zshrc" ~/.zshrc
ln -fs "$HOME/.dotfiles/.p10k.zsh" ~/.p10k.zsh
ln -fs "$HOME/.dotfiles/.gitconfig" ~/.gitconfig
ln -fs "$HOME/.dotfiles/.zsh_history" ~/.zsh_history

## fonts
if [ "$(uname)" = "Darwin" ]; then
  brew install zsh-autosuggestions zsh-syntax-highlighting
  cp -r $HOME/.dotfiles/.fonts/* "$HOME/Library/Fonts"
else
  cp -r $HOME/.dotfiles/.fonts/* "$HOME/.local/share/fonts"
fi
