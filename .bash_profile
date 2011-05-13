#to load .bashrc everytime when I login
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

#set General Path
export PATH=/usr/local/bin/:/usr/local/sbin/:/opt/local/bin/:/opt/local/sbin/:$HOME/bin:$PATH
#$DYLD_LIBRARY_PATH:$PATH

#set Maven 2 Path
export M2_HOME=/usr/share/maven
export PATH=$M2_HOME/bin:$PATH

#set Path for Ruby Version Manager
export PATH=$HOME/.rvm/bin:$PATH

#set Path for JMeter
#export PATH=$HOME/src/JMeter/trunk/bin:$PATH

#set Path for Gems
export PATH=vendor/gems/bin:$PATH
export GEM_PATH=$HOME/parity/vendor/gems/ruby/1.8:$GEM_PATH

MANPATH=/opt/local/share/man:$MANPATH

#export RDOCOPT="-S -f html -T hanna"

#Better Practice
export RUBYOPT=rubygems

#For Paste Bin (already included at very top of the file)
#export PATH=$HOME/bin:$PATH

#Cucumber
export CUCUMBER_DEBUG=true
export CUCUMBER_FORMAT=pretty 

# Oracle Instant Client, Version 10.2.0.4
export DYLD_LIBRARY_PATH=$HOME/local/oracle/instantclient_10_2
export ORACLE_HOME=$HOME/local/oracle/instantclient_10_2
export SQLPATH=$HOME/local/oracle/instantclient_10_2
export TNS_ADMIN=$HOME/local/oracle/instantclient_10_2/network/admin
export NLS_LANG="AMERICAN_AMERICA.UTF8"
export PATH=$DYLD_LIBRARY_PATH:$PATH

export JSPIDER_HOME=$HOME/local/jspider
export PATH=$JSPIDER_HOME/bin:$PATH

# For irssi
# export PERL5LIB=/opt/local/lib/perl5/darwin/darwin-2level:$PERL5LIB

[[ -s $HOME/.rvm/scripts/rvm ]] && source "$HOME/.rvm/scripts/rvm"

# MacPorts Bash shell command completion
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# Set History File Size
HISTFILESIZE=1000000000
HISTSIZE=1000000

#############################
# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
