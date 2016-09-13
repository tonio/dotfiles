# OhMyZsh -----------------------------------------------------------------{{{
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
# export ZSH_THEME="lambda"
# export ZSH_THEME="avit"
export PURITY_GIT_PULL=0
export ZSH_THEME="purity"
export DISABLE_AUTO_UPDATE="true"

PURE_PROMPT_SYMBOL="λ"

# 256 colors
export TERM="xterm-256color"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(git brew osx virtualenv zsh-syntax-highlighting )
plugins=(git  virtualenv zsh-syntax-highlighting )

# Nicer prompt
source $ZSH/oh-my-zsh.sh

source ~/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Customize `avit` theme
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}×%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}•%{$reset_color%}"

# }}}

# Paths -------------------------------------------------------------------{{{
export PATH=$HOME/local/node/bin:$HOME/bin:/usr/local/bin:$HOME/.bin
export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:usr/local/git/bin:/usr/X11/bin:/opt/local/bin
export PATH=$PATH:/Library/PostgreSQL/8.4/bin
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:/usr/games
export PATH=$PATH:$HOME/.local/bin
export NODE_PATH=/usr/local/lib/node_modules

#unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles
# }}}

# Utilities ---------------------------------------------------------------{{{
# z is the new j
source $HOME/.zsh/z-zsh/z.sh
function precmd () {
    z --add "$(pwd -P)"
}
alias j=z
alias f='find . -name'

# quicklook
alias ql='qlmanage -p 2>&1 > /dev/null'

# task list
alias task='python ~/Documents/Dropbox/bin/t.py --task-dir ~/Documents/Dropbox/tasks --list tasks'

# Edit current line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# coherent less output
export LESS='-R -F -X'

# tmux
alias tma='tmux attach -t'
# if [[ -s  "`brew --prefix grc`/etc/grc.bashrc" ]] ; then source "`brew --prefix grc`/etc/grc.bashrc" ; fi
export DISABLE_AUTO_TITLE=true
if [[ -s $HOME/.bin/tmuxinator.sh ]] ; then source ~/.bin/tmuxinator.sh ; fi
# }}}

# dircolors
if [[ -s /usr/local/bin/gdircolors ]] ; then
    eval `gdircolors $HOME/.dotfiles/zsh/dircolors-solarized/dircolors.256dark`
; else
    eval `dircolors $HOME/.dotfiles/zsh/dircolors-solarized/dircolors.256dark`
; fi
if [[ -s /usr/local/bin/gls ]] ; then
    alias ls='gls --color=auto'
; fi

# ts helpers
alias ts="pmset -g log | grep -v Dark | grep -v Maintenance | grep -e 'Wake   ' -e 'Entering'"

# fucking mouse
alias tp='rfkill block 0 && sleep 1 && rfkill unblock 0 && hidd --connect D8:A2:5E:FD:AF:2A'

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
alias git-co-externals='git svn show-externals | grep "^/" | sed "s|^/\([^ ]*\)\(.*\) \(.*\)|(mkdir -p \1 \&\& cd \1 \&\& if [ -d .svn ]; then echo \"svn up \2 \1\" \&\& svn up \2 ; else echo \"svn co \2 \3 \1\" \&\& svn co \2 \3 . ; fi)|" | sh'
alias gitroot='cd $(git rev-parse --show-cdup)'
alias gr=gitroot
alias gs='git st'
alias ga='git add -p'
alias svnd='svn diff | colordiff | less'
# }}}

# Vim ---------------------------------------------------------------------{{{
export EDITOR=vim
alias vi='vim'
alias o='mvim'
alias v='vim -u NONE'
# }}}
# Utils -------------------------------------------------------------------{{{
alias kdev="kill -9 $(ps aux | grep firefox | grep nobackup | head -1 | awk '{print $2}')"
# }}}

# VirtualEnvWrapper -------------------------------------------------------{{{
export WORKON_HOME=~/Library/Envs
if [[ -s $HOME/.local/bin/virtualenvwrapper.sh ]] ; then alias vv='source ~/.local/bin/virtualenvwrapper.sh' ; fi
# }}}

# Local settings ----------------------------------------------------------{{{
function strip_diff_leading_symbols(){
color_code_regex="(\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K])"

# simplify the unified patch diff header
sed -r "s/^($color_code_regex)diff --git .*$//g" | \
    sed -r "s/^($color_code_regex)index .*$/\n\1$(rule)/g" | \
    sed -r "s/^($color_code_regex)\+\+\+(.*)$/\1+++\5\n\1$(rule)\x1B\[m/g" | \
    sed -r "s/^($color_code_regex)[\+\-]/\1 /g"
 }

 # Print a horizontal rule
 rule () {
     printf "%$(tput cols)s\n"|tr " " "─"
 }
# }}}
# Local settings ----------------------------------------------------------{{{
if [[ -s $HOME/.zshrc_local ]] ; then source $HOME/.zshrc_local ; fi
# }}}

export NVM_DIR="/home/aabt/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
