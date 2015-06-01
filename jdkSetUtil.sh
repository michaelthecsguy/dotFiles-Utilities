function setJDK() {
  if [ $# -ne 0 ]; then
	switchJDK $@
  else
	echo “Choose from the following Java versions:”
  	listJDK
	echo “Please enter the correct full version number:”
	read jdkPick
	switchJDK $jdkPick
  fi
}

function switchJDK() {
  removeFromPath ‘/System/Library/Frameworks/JavaVM.framework/Home/bin’
  if [ -n “${JAVA_HOME+x}” ]; then
	removeFromPath $JAVA_HOME
  fi
  export JAVA_HOME=`/usr/libexec/java_home -v $@`
  export PATH=$JAVA_HOME/bin:$PATH
}

function listJDK() {
  allVersions=$(/usr/libexec/java_home -V)
}

function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

function jdkNow()
{
  `java -version`
}
