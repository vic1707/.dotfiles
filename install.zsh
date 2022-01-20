ln -s "$HOME/.dotfiles/.zshrc" ~/.zshrc
ln -s "$HOME/.dotfiles/.p10k.zsh" ~/.p10k.zsh
ln -s "$HOME/.dotfiles/.gitconfig" ~/.gitconfig
ln -s "$HOME/.dotfiles/.zsh_history" ~/.zsh_history

## fonts
if [ "$(uname)" = "Darwin" ]; then
  cp -r $HOME/.dotfiles/.fonts/* "$HOME/Library/Fonts"
else
  cp -r $HOME/.dotfiles/.fonts/* "$HOME/.local/share/fonts"
fi