# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# set the terminal variable to xterm-256 color (to make sure C-arrows
# combos work in vim inside tmux) - discouraged but it works
# export TERM=xterm-256color

# # usually, modern terminals that declare themselves as "xterm" actually have
# # 256 color compatibility, so we set the TERM variable accordingly
# if [ "$TERM" == "xterm" ]; then
#     export TERM=xterm-256color
# fi

# little welcome message when you startup the terminal
fortune | cowsay && echo ''

# disable start/stop signals to be sent with C-s and C-q to the terminal
# so we can remap them to other things
stty -ixon -ixoff

# disable the end of file command (that exits the shell) to be sent with C-d
set -o ignoreeof

# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# trim the length of the pwd
export PROMPT_DIRTRIM=3

# to fix xdg warnings when running GUI applications with Qt5 backend
export XDG_RUNTIME_DIR='/tmp/runtime-fboccardo'
export RUNLEVEL=3
export LIBGL_ALWAYS_INDIRECT=1 

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# if set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# you may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# see /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# # alias for resetting the display variable to local
# # (might get stuck after connecting to tmux via SSH)
# alias disp-reset='export DISPLAY=:0.0'
# alias disp-ssh='export DISPLAY=localhost:10.0'

# set the display variable so that it connects with the x11 server in win
export DISPLAY=localhost:0.0

# shorter aliases for frequent commands
alias vi='vim'
alias py='python'
alias run='python'
alias ipy='ipython --no-autoindent'
alias ta='tmux a'

# set the remove and move commands to be interactive (prompt to remove or overwrite)
# it can be overridden by using rm -f and mv -f
alias rm="rm -i"
alias mv="mv -i"

# copy the PWD to the Clipboard (requires xclip)
alias cpwd="pwd | tr -d '\n' | xclip -selection c && echo 'pwd copied to clipboard'"

# alias to use instead of the regular git to interact with our configuration repository (created with: git init --bare $HOME/.cfg )
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# open the current path in the file explorer
# alias exp='xdg-open . 2>/dev/null'
alias exp='explorer.exe .'

# reload bashrc
alias reload="source ~/.bashrc && echo '.bashrc reloaded'"

# this function lets you quit ranger normally with q, but changes dir to last location if you quit with Q
# https://github.com/ranger/ranger/wiki/Integration-with-other-programs#changing-directories
function ranger {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command ranger --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )
    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}

# # open a new instance of chrome so it can be correctly sent via ssh X forwarding
# alias chrome-ssh="google-chrome --user-data-dir=/tmp"

# # connect via ssh to ilm machine and cd to same directory
# function ilm() {
#     ssh -t ilmfixe$1 "cd $PWD ; bash"
# }

# connect to ilm fixe
alias fixe='ssh -X ilmfixe'

alias sync='sync_from_cluster'
sync_from_cluster() {
	read -r -p "are you sure you want to sync results from cluster? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		rsync -rhav cluster:olfactory_research/results/ /home/fboccardo/Documents/Postdoc/olfactory_research/results/ 2> /dev/null
		echo 'sync completed'
	else
		echo 'sync cancelled'
	fi
}

# # sync current folder from fixe
# alias sync='sync_from_fixe'
# sync_from_fixe() {
# 	read -r -p "Are you sure you want to sync $PWD? [y/N] " response
# 	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
# 	then
# 		rsync --progress -havze ssh ilmfixe:$PWD/ $PWD
# 		echo 'Sync completed'
# 	else
# 		echo 'Sync cancelled'
# 	fi
# }

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/fboccardo/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/fboccardo/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/fboccardo/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/fboccardo/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
