#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR="emacsclient -t -a nano"

#TERMINAL CONVENIENCE
PATH=$(cope_path):$PATH
export PATH=~/.bin:$PATH
alias ls='ls --color=auto'
PS1="\[\e[32m\]\W\[\e[m\] $ \[$(tput sgr0)\]"
shopt -s checkwinsize

# ALIASES
alias emc='emc -nw'
alias semc="SUDO_EDITOR=\"emc -nw\" sudo -e"


#ELM
ELM_HOME=/usr/lib/node_modules/elm/share

#HASKELL
eval "$(stack --bash-completion-script "$(which stack)")"
export PATH=~/.cabal/bin:$PATH

#IDRIS
export PATH=~/workspace/idris/bin:$PATH

#RUBY
export PATH=/home/whitehead/.gem/ruby/2.2.0/bin/:$PATH

# POCKET SPHINX
export LD_LIBRARY_PATH=/usr/local/lib
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

#WINE
export WINEPREFIX=$HOME/.config/wine/
export WINEARCH=win32

#ANDROID
export ANDROID_HOME=~/Android/Sdk
