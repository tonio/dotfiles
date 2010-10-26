# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="robbyrussell"

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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$HOME/bin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/X11/bin:/opt/local/bin

# Nicer prompt
source $HOME/.prose.zsh-theme

# Battery indicator
export BAT_CHARGE=$HOME/bin/batcharge.py
RPROMPT='$(battery_charge)'

# z is the new j
. $HOME/.zsh/z-zsh/z.sh
function precmd () {
    z --add "$(pwd -P)"
}

# task list
alias t='python ~/bin/t/t.py --task-dir ~/Documents/Dropbox/tasks --list tasks'

# cd to git root dir
alias gitroot='cd $(git rev-parse --show-cdup)'

# static serve files
alias serve='python -m SimpleHTTPServer'

# vim only
alias vi='vim'
