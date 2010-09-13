# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Scavenged from Git 1.6.5.x contrib/completion/git_completion.bash
# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
# returns text to add to bash PS1 prompt (includes branch name)
__gitdir ()
{
  if [ -z "${1-}" ]; then
    if [ -n "${__git_dir-}" ]; then
      echo "$__git_dir"
    elif [ -d .git ]; then
      echo .git
    else
      git rev-parse --git-dir 2>/dev/null
    fi
  elif [ -d "$1/.git" ]; then
    echo "$1/.git"
  else
    echo "$1"
  fi
}
__git_ps1 ()
{
  local g="$(__gitdir)"
  if [ -n "$g" ]; then
    local r
    local b
    if [ -f "$g/rebase-merge/interactive" ]; then
      r="|REBASE-i"
      b="$(cat "$g/rebase-merge/head-name")"
    elif [ -d "$g/rebase-merge" ]; then
      r="|REBASE-m"
      b="$(cat "$g/rebase-merge/head-name")"
    else
      if [ -d "$g/rebase-apply" ]; then
        if [ -f "$g/rebase-apply/rebasing" ]; then
          r="|REBASE"
        elif [ -f "$g/rebase-apply/applying" ]; then
          r="|AM"
        else
          r="|AM/REBASE"
        fi
      elif [ -f "$g/MERGE_HEAD" ]; then
        r="|MERGING"
      elif [ -f "$g/BISECT_LOG" ]; then
        r="|BISECTING"
      fi

      b="$(git symbolic-ref HEAD 2>/dev/null)" || {

        b="$(
        case "${GIT_PS1_DESCRIBE_STYLE-}" in
        (contains)
          git describe --contains HEAD ;;
        (branch)
          git describe --contains --all HEAD ;;
        (describe)
          git describe HEAD ;;
        (* | default)
          git describe --exact-match HEAD ;;
        esac 2>/dev/null)" ||

        b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
        b="unknown"
        b="($b)"
      }
    fi

    local w
    local i
    local s
    local u
    local c

    if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
      if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
        c="BARE:"
      else
        b="GIT_DIR!"
      fi
    elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
      if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
        if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
          git diff --no-ext-diff --ignore-submodules \
            --quiet --exit-code || w="*"
          if git rev-parse --quiet --verify HEAD >/dev/null; then
            git diff-index --cached --quiet \
              --ignore-submodules HEAD -- || i="+"
          else
            i="#"
          fi
        fi
      fi
      if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
              git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
      fi

      if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
         if [ -n "$(git ls-files --others --exclude-standard)" ]; then
            u="%"
         fi
      fi
    fi

    if [ -n "${1-}" ]; then
      printf "$1" "$c${b##refs/heads/}$w$i$s$u$r"
    else
      printf " (%s)" "$c${b##refs/heads/}$w$i$s$u$r"
    fi
  fi
}

export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWSTASHSTATE=1

if [ "$color_prompt" = yes ]; then
 #    PS1="${debian_chroot:+$debian_chroot }[\[\033[1;34m\] \w \[\033[00m\]]\[\033[0m\] \[\033[0m\]\n\[\033[1;32m\]\u\[\033[1;34m\] \$ \[\033[0m\]"
 #    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
 # En fait l'important ici c'est le "\033[1;32m\]$(__git_ps1)\[\033[0m\]", le reste c'est mon prompt usuel…
    export PS1='\[\033[0;37m\]\u@\h:\[\033[0;33m\]\W\[\033[0m\]\[\033[1;32m\]$(__git_ps1)\[\033[0m\] \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

function svndiff () {
    svn diff $@ | colordiff;
}

function findandedit() {
    find . -name $@ -exec vim \{\} \;
}

alias svns='svn status --ignore-externals | grep -v .swp | grep -v .swo'
alias svni='svn info'
alias cvsstatus='cvs status 2>&1 | egrep "(^\? |Status: )" | grep -v Up-to-date'

#export LC_ALL='fr_FR.UTF-8'

export EDITOR=vim

alias svnd='svn diff --diff-cmd colordiff'

alias ack='~/.bin/ack-standalone'

source ~/.bashrc_after
