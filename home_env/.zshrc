export PATH="/usr/local/sbin:$PATH"

export PATH="/usr/local/opt/openjdk/bin:$PATH"
JAVA_HOME=/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home
export JAVA_HOME
export ATLAS_HOME=/usr/local/Cellar/atlassian-plugin-sdk/8.2.6
export PATH=$PATH:$JAVA_HOME/bin:$ATLAS_HOME/bin

GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}
