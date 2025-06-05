### -------------- Source common -------------------
[ -f "$HOME/.dotfiles/.commonrc" ] && source "$HOME/.dotfiles/.commonrc"

### -------------- History -------------------
export HISTFILE=~/.bash_history
export HISTSIZE=50000
export HISTFILESIZE=$HISTSIZE

### -------------- fzf -------------------
if [ -f "/usr/share/doc/fzf/examples/key-bindings.bash" ]; then
    source "/usr/share/doc/fzf/examples/key-bindings.bash"
fi
