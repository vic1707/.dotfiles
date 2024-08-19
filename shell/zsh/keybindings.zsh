#!/bin/zsh

###################
# ZSH keybindings #
###################

# declare key
typeset -A key

# Default key bindings (Linux/Unix-like systems)
# to get the codes you can
# `cat -v` and type
# `stty -a | grep erase` or others
key[Home]="^[[H"
key[End]="^[[F"
key[Insert]="^[[2~"
key[Up]="^[[A"
key[Down]="^[[B"
key[Shift_Tab]="^[[Z"
# Can be os/platform specific
key[Control_Left]="^[Od"    # or "^[1;5D"
key[Control_Right]="^[Oc"   # or "^[1;5C"
key[Control_Backspace]="^W" # This may vary depending on the terminal

# OS-specific overrides (macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    key[Control_Left]="^[b"
    key[Control_Right]="^[f"
    key[Control_Backspace]="^H"
    # CMD + Left/Right bindings
    key[Cmd_Left]="^A"   # CMD + Left (start of line)
    key[Cmd_Right]="^E"  # CMD + Right (end of line)
fi

# setup key accordingly
bindkey -- "${key[Home]}" beginning-of-line
bindkey -- "${key[End]}" end-of-line
bindkey -- "${key[Insert]}" overwrite-mode
bindkey -- "${key[Up]}" up-line-or-beginning-search
bindkey -- "${key[Down]}" down-line-or-beginning-search
bindkey -- "${key[Shift_Tab]}" reverse-menu-complete
bindkey -- "${key[Control_Left]}" backward-word
bindkey -- "${key[Control_Right]}" forward-word
bindkey -- "${key[Control_Backspace]}" backward-kill-word

# CMD + Left/Right only if defined (so MacOs only)
[[ -n "${key[Cmd_Left]}" ]] && bindkey -- "${key[Cmd_Left]}" beginning-of-line
[[ -n "${key[Cmd_Right]}" ]] && bindkey -- "${key[Cmd_Right]}" end-of-line
