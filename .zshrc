# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="prose"
export DISABLE_AUTO_UPDATE="true"

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
plugins=(git command-coloring brew osx)

# Nicer prompt
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$HOME/local/node/bin:$HOME/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:usr/local/git/bin:/usr/X11/bin:/opt/local/bin:/Library/PostgreSQL/8.4/bin
export NODE_PATH=/usr/local/lib/node_modules

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# z is the new j
source $HOME/.zsh/z-zsh/z.sh
function precmd () {
    z --add "$(pwd -P)"
}
alias j=z
alias f='find . -name'

# task list
alias t='python ~/Documents/Dropbox/bin/t.py --task-dir ~/Documents/Dropbox/tasks --list tasks'

# git svn externals
alias git-co-externals='git svn show-externals | grep "^/" | sed "s|^/\([^ ]*\)\(.*\) \(.*\)|(mkdir -p \1 \&\& cd \1 \&\& if [ -d .svn ]; then echo \"svn up \2 \1\" \&\& svn up \2 ; else echo \"svn co \2 \3 \1\" \&\& svn co \2 \3 . ; fi)|" | sh'

# cd to git root dir
alias gitroot='cd $(git rev-parse --show-cdup)'

# svn
alias svnd='svn diff | colordiff | less'

# vim only
export EDITOR=vim
alias vi='vim'
alias o='mvim'

# coherent less output
export LESS='-R -F -X'

# tmux
alias tma='tmux attach -t'

# virtualenvwrapper
export WORKON_HOME=~/Library/Envs
if [[ -s /usr/local/bin/virtualenvwrapper.sh ]] ; then alias vv='source /usr/local/bin/virtualenvwrapper.sh' ; fi

# local settings
if [[ -s $HOME/.zshrc_local ]] ; then source $HOME/.zshrc_local ; fi
