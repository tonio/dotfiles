# 256 colors
export TERM="xterm-256color"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=248'

# Antigen {{{
source zsh/antigen.zsh

antigen bundle git
antigen bundle tmuxinator
antigen bundle virtualenv
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle chrissicool/zsh-256color
antigen bundle zpm-zsh/ssh
antigen theme subnixr/minimal
# export PROMPT_LEAN_TMUX=""
# antigen theme miekg/lean
# }}}

# Paths -------------------------------------------------------------------{{{
export PATH=$HOME/local/node/bin:$HOME/bin:/usr/local/bin:$HOME/.bin
export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:usr/local/git/bin:/usr/X11/bin:/opt/local/bin
export PATH=$PATH:/Library/PostgreSQL/8.4/bin
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:/usr/games
export PATH=$PATH:$HOME/.local/bin
export NODE_PATH=/usr/local/lib/node_modules
export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:$HOME/nobackup/go/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# }}}

# Utilities ---------------------------------------------------------------{{{

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# vi mode
set -o vi
export KEYTIMEOUT=1

# Edit current line
autoload -U edit-command-line
autoload -U zmv
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

bindkey '^R' history-incremental-search-backward
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^w' backward-kill-word
bindkey '^e' vi-forward-char


# coherent less output
export LESS='-R -F -X'

if [[ -s $HOME/.bin/tmuxinator.sh ]] ; then source ~/.bin/tmuxinator.sh ; fi
# }}}

# dircolors
eval `dircolors $HOME/.dotfiles/zsh/dircolors-solarized/dircolors.256dark`
alias l="ls --color"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=248'

# ts helpers
alias ts="pmset -g log | grep -v Dark | grep -v Maintenance | grep -e 'Wake   ' -e 'Entering'"

# headers
alias headers="curl -I -s -X GET"

#grep colors
export GREP_COLOR='2;31'

# }}}

# auto-ls on cd -----------------------------------------------------------{{{
auto-ls () {
    emulate -L zsh;
    # explicit sexy ls'ing as aliases arent honored in here.
    hash gls >/dev/null 2>&1 && CLICOLOR_FORCE=1 gls -aFh --color --group-directories-first || ls
}
chpwd_functions=( auto-ls $chpwd_functions )
# }}}

# Go ----------------------------------------------------------------------{{{
export GOPATH=/home/aabt/nobackup/go
# }}}

# Git ---------------------------------------------------------------------{{{
alias g=git
alias groot='cd $(git rev-parse --show-cdup)'
# }}}

# Vim ---------------------------------------------------------------------{{{
if ([ -f /home/linuxbrew/.linuxbrew/bin/nvim ]) ; then
  export EDITOR=nvim
  alias vi='nvim'
  alias v='nvim -u NONE'
else
  export EDITOR=vim
  alias vi='vim'
  alias v='vim -u NONE'
fi
# }}}

# Utils -------------------------------------------------------------------{{{
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias scat='source-highlight --out-format=esc -o STDOUT -i '
alias ack=rg
# }}}

# VirtualEnvWrapper -------------------------------------------------------{{{
export WORKON_HOME=~/Library/Envs
if [[ -s $HOME/.local/bin/virtualenvwrapper.sh ]] ; then alias vv='source ~/.local/bin/virtualenvwrapper.sh' ; fi
# }}}

export NVM_DIR="/home/aabt/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm

_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"

  # Comment and uncomment below for the light theme.

  # Solarized Dark color scheme for fzf
  # export FZF_DEFAULT_OPTS="
  #   --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
  #   --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
  # "
  ## Solarized Light color scheme for fzf
  export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
  "
}
_gen_fzf_default_opts

function zsh-stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n25;
}

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=248'
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=248'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# added by travis gem
[ -f /home/aabt/.travis/travis.sh ] && source /home/aabt/.travis/travis.sh

export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
