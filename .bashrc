### -------------- Source common -------------------
[ -f "$HOME/.commonrc" ] && source "$HOME/.commonrc"

### -------------- History -------------------
export HISTFILE=~/.bash_history
export HISTSIZE=50000
export HISTFILESIZE=$HISTSIZE

### -------------- fzf -------------------
if [ -f "/usr/share/doc/fzf/examples/key-bindings.bash" ]; then
    source "/usr/share/doc/fzf/examples/key-bindings.bash"
fi

### --------------- git shortcuts ------------------
# ---------- git shortcuts ------------
function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

function git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function current_branch() {
  git_current_branch
}

function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}

function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo develop
}

alias ga='git add'
alias gaa='git add --all'
alias gc='git commit --verbose'
alias gcmsg='git commit --message'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout $(git_main_branch)'
alias gcd='git checkout $(git_develop_branch)'
alias gcl='git clone --recurse-submodules'
alias gl='git pull'
alias gp='git push'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gsu='git submodule update --init'
alias gsur='git submodule update --init --recursive'