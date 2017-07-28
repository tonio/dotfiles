# 256 colors
export TERM="xterm-256color"

# Antigen {{{
source zsh/antigen.zsh

antigen bundle git
antigen bundle tmuxinator
antigen bundle ssh-agent
antigen bundle virtualenv
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
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
# }}}

# Utilities ---------------------------------------------------------------{{{

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# Edit current line
bindkey -e
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# coherent less output
export LESS='-R -F -X'

if [[ -s $HOME/.bin/tmuxinator.sh ]] ; then source ~/.bin/tmuxinator.sh ; fi
# }}}

# dircolors
eval `dircolors $HOME/.dotfiles/zsh/dircolors-solarized/dircolors.256dark`
alias l="ls --color"

# ts helpers
alias ts="pmset -g log | grep -v Dark | grep -v Maintenance | grep -e 'Wake   ' -e 'Entering'"

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
alias gitroot='cd $(git rev-parse --show-cdup)'
# }}}

# Vim ---------------------------------------------------------------------{{{
if ([ -f /usr/bin/nvim ]) ; then
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
# }}}

# VirtualEnvWrapper -------------------------------------------------------{{{
export WORKON_HOME=~/Library/Envs
if [[ -s $HOME/.local/bin/virtualenvwrapper.sh ]] ; then alias vv='source ~/.local/bin/virtualenvwrapper.sh' ; fi
# }}}

export NVM_DIR="/home/aabt/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# added by travis gem
[ -f /home/aabt/.travis/travis.sh ] && source /home/aabt/.travis/travis.sh
