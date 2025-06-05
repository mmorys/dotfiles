### -------------- Powerlevel10k instant prompt -------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### -------------- Source common -------------------
[ -f "$HOME/.dotfiles/.commonrc" ] && source "$HOME/.dotfiles/.commonrc"

### -------------- History -------------------
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

### -------------- Exports -------------------
fpath=(~/.local/share/zsh/functions $fpath)

### -------------- Zap -------------------
export ZAP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zap"

if [ ! -f "$ZAP_DIR/zap.zsh" ]; then
	git clone https://github.com/mmorys/zap.git "$ZAP_DIR" &> /dev/null
fi
if [ -f "$ZAP_DIR/zap.zsh" ]; then
	[ -f "${ZAP_DIR}/zap.zsh" ] && source "${ZAP_DIR}/zap.zsh"
	plug "zsh-users/zsh-autosuggestions"
	command -v eza &> /dev/null && plug "zap-zsh/exa"
	command -v fzf &> /dev/null && plug "zap-zsh/fzf"
	command -v fzf &> /dev/null && plug "Aloxaf/fzf-tab"
	plug "chivalryq/git-alias"
	plug "mmorys/dirhistory"
	plug "romkatv/powerlevel10k"
	plug "zsh-users/zsh-syntax-highlighting"

	# Load and initialise completion system
	autoload -Uz compinit
	for dump in ~/.zcompdump(N.mh+24); do
	    compinit
	done
	compinit -C
fi


### -------------- Powerlevel10k -------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

