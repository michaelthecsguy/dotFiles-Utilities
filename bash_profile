#to load .bashrc everytime if available when I login
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

#export PS1="________________________________________________________________________________\n| \w @ \h (\u) \n| => "
#export PS2="| => "

#Homebrew Bash shell command completion - Pre-requisite - has to download Bash Completion from Homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

#MacPorts Bash shell command completion - Pre-requisite - has to download Bash Completion from MacPorts
#if [ -f /opt/local/etc/bash_completion ]; then
#    . /opt/local/etc/bash_completion
#fi

#For Paste Bin (already included at very top of the file)
#export PATH=$HOME/bin:$PATH

#Set Manual command
#MANPATH=/opt/local/share/man:$MANPATH

#Set History File Size
HISTFILESIZE=10000000000
HISTSIZE=100000000

#Set General Path to include Macport Software Installation and Homebrew
export PATH=/sbin:/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:$HOME/bin:$PATH

###For Ruby Development Environment###
#RVM - Ruby Version Management
[[ -s $HOME/.rvm/scripts/rvm ]] && source "$HOME/.rvm/scripts/rvm"
#Set Path for Ruby Version Manager
export PATH=$HOME/.rvm/bin:$PATH

#Set Path for Gems
export PATH=vendor/gems/bin:$PATH
export GEM_PATH=$HOME/parity/vendor/gems/ruby/1.8:$GEM_PATH

#Better Practice
export RUBYOPT=rubygems

#Cucumber
export CUCUMBER_DEBUG=true
export CUCUMBER_FORMAT=pretty 

#Set rDoc - Ruby Doc
#export RDOCOPT="-S -f html -T hanna"

#Set irssi chat tool (from Sean Gallagher)
#export PERL5LIB=/opt/local/lib/perl5/darwin/darwin-2level:$PERL5LIB

###For Java Development Environment###
#Set JAVA
export JAVA_HOME=$(/usr/libexec/java_home -v '1.8*')
export PATH=$JAVA_HOME/bin:$PATH
PWD=$(pwd)
. "$PWD/jdkSetUtil.sh" #to include the shell script


#Set Maven
export M2_HOME=/usr/local/apache-maven/apache-maven-3.3.3
export PATH=$M2_HOME/bin:$PATH

#Set Path for JBOSS
JBOSS_HOME=/Users/myang/jboss-5.1.0.GA
export JBOSS_HOME
export PATH=${JBOSS_HOME}/bin:${PATH}

#Set Path for JAVA in Local Box
export JAVA_HOME
export JDK_HOME=$JAVA_HOME
export JBOSS_DEPLOY_DIR=$JBOSS_HOME/server/web/deploy
export JBOSS_SERVER=web

#Set jSpider for web crawler
#https://paritoshranjan.wordpress.com/2010/07/05/220/
#export JSPIDER_HOME=$HOME/local/jspider
#export PATH=$JSPIDER_HOME/bin:$PATH

#Set Path for JMeter
#export PATH=$HOME/src/JMeter/trunk/bin:$PATH

#Set Oracle DB Instant Client, Version 10.2.0.4 32 bits for Ruby Automation || Newest Version 11.2.0.4.0 (64-bit)
export DYLD_LIBRARY_PATH=$HOME/local/oracle/instantclient_10_2_32
export ORACLE_HOME=$HOME/local/oracle/instantclient_10_2_32
export SQLPATH=$HOME/local/oracle/instantclient_10_2_32
export TNS_ADMIN=$HOME/local/oracle/instantclient_10_2_32/network/admin
export NLS_LANG="AMERICAN_AMERICA.UTF8"
export PATH=$DYLD_LIBRARY_PATH:$PATH

#Set MySQL
export PATH=/usr/local/mysql/bin:$PATH

########################################
#Setting PATH for Python 2.7
#The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
#export PATH
export PYENV_ROOT=/usr/local/var/pyenv
export PATH=~/anaconda/bin:$PATH
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

########################################
########################################
#Setting PATH for Java in Unix Dev Box
#export TPKG_HOME=/home/t
#PATH=$PATH:$TPKG_HOME/bin
#export PATH
#export JAVA_HOME=$TPKG_HOME/jdk_current
#export JDK_HOME=$JAVA_HOME
#export MAVEN_HOME=$TPKG_HOME/apache-maven-2.2.1
#export JBOSS_HOME=$TPKG_HOME/jboss-5.1.0.GA
#export JBOSS_DEPLOY_DIR=$JBOSS_HOME/server/web/deploy
export SVN_EDITOR=vim
export SVN_ROOT=http://svn.specificmedia.com/svn/projects
#export JAVA_OPTS="$JAVA_OPTS -ea -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=29462"
export JAVA_OPTS="-ea -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=29462"

#######################################
#######################################
#Setting up Go Environment
export GOPATH="/Users/myang/go"
export GOROOT="/usr/local/Cellar/go/1.6.2/libexec"

######################################
######################################
# The next line updates PATH for the Google Cloud SDK.
#source '/Users/myang/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/Users/myang/google-cloud-sdk/completion.bash.inc'

#####################################
####################################
# added for aws
export PATH="~/Library/Python/3.6/bin:$PATH"

# added by Anaconda2 4.2.0 installer
export PATH="/Users/myang/anaconda/bin:$PATH"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
