#!/bin/zsh

###################
# ZSH keybindings #
###################

# declare key & terminfo
typeset -g -A key
typeset -g -A terminfo

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift_Tab]="${terminfo[kcbt]}"
key[Control_Left]="${terminfo[kLFT5]}"
key[Control_Right]="${terminfo[kRIT5]}"
key[Control_Backspace]="${terminfo[kDC3]}"
key[Control_Delete]="${terminfo[kDC4]}"

# setup key accordingly
[[ -n ${key[Home]} ]] && bindkey -- "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey -- "${key[End]}" end-of-line
[[ -n ${key[Insert]} ]] && bindkey -- "${key[Insert]}" overwrite-mode
[[ -n ${key[Backspace]} ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n ${key[Delete]} ]] && bindkey -- "${key[Delete]}" delete-char
[[ -n ${key[Up]} ]] && bindkey -- "${key[Up]}" up-line-or-beginning-search
[[ -n ${key[Down]} ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search
[[ -n ${key[Left]} ]] && bindkey -- "${key[Left]}" backward-char
[[ -n ${key[Right]} ]] && bindkey -- "${key[Right]}" forward-char
[[ -n ${key[PageUp]} ]] && bindkey -- "${key[PageUp]}" beginning-of-buffer-or-history
[[ -n ${key[PageDown]} ]] && bindkey -- "${key[PageDown]}" end-of-buffer-or-history
[[ -n ${key[Shift_Tab]} ]] && bindkey -- "${key[Shift_Tab]}" reverse-menu-complete
[[ -n ${key[Control_Left]} ]] && bindkey -- "${key[Control_Left]}" backward-word
[[ -n ${key[Control_Right]} ]] && bindkey -- "${key[Control_Right]}" forward-word
[[ -n ${key[Control_Backspace]} ]] && bindkey -- "${key[Control_Backspace]}" backward-kill-word
[[ -n ${key[Control_Delete]} ]] && bindkey -- "${key[Control_Delete]}" kill-word
