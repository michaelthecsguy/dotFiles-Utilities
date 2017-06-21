export EDITOR='/Users/myang/bin/vim'
export VISUAL='/Users/myang/bin/mvim'

set history=1000000000

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# -F option decorates the filenames with special characters: 
# a “/” after directory names, 
# a “*” after executable files, 
# a “@” after soft links.
alias ls='ls -F'

# Run it as follows to get top 10 files/dirs eating your disk space
alias ducks='du -cks * | sort -rn | head'

# Get rid of .DS_Store files
alias nomore='find ./ -iname .DS_Store -delete'

## this is to fool the automounter without showing username and computer
cd ${HOME}

# Selenium Test
export CUCUMBER_FORMAT=pretty
export CUCUMBER_DEBUG=true

# JellyFish from webypqa
export RUBYOPT="rubygems"

# Enable colors in OSX terminal
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

################################################################
# Git prompt
 parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
 }
 export PS1="\w\[\e[0;32;49m\]\$(parse_git_branch)\[\e[0;0m\]$ "
 export GIT_PS1_SHOWDIRTYSTATE=yes
 export GIT_PS1_SHOWUNTRACKEDFILES=yes
 . ~/.git-completion.sh  
#################################################################
[[ -s $HOME/.rvm/scripts/rvm ]] && source "$HOME/.rvm/scripts/rvm"

###TODO: Do not know why the line below exists
#source /usr/local/opt/chruby/share/chruby/chruby.sh
