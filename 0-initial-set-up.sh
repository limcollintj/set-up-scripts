#!/bin/bash

printf "\n1.Changing scripts to executables"

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TARGET=$(readlink "$SOURCE")
  if [[ $TARGET == /* ]]; then
    echo "SOURCE '$SOURCE' is an absolute symlink to '$TARGET'"
    SOURCE=$TARGET
  else
    DIR=$( dirname "$SOURCE" )
    echo "SOURCE '$SOURCE' is a relative symlink to '$TARGET' (relative to '$DIR')"
    SOURCE=$DIR/$TARGET # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  fi
done
RDIR=$( dirname "$SOURCE" )
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
if [ "$DIR" != "$RDIR" ]; then
  echo "DIR '$RDIR' resolves to '$DIR'"
fi

chmod u+x $DIR/2-set-up-packages.sh
chmod u+x $DIR/1-set-up-casks.sh
chmod u+x $DIR/3-change-screenshot-location.sh




#Downloads brew
printf "\n2.downloading brew"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#Change default screenshot folder location 
printf "\n2.Changing default screenshots location"

$DIR/3-change-screenshot-location.sh

# Downloading applications
printf "\n Downloading applications"

#Downloading Brew casks
$DIR/1-set-up-casks.sh

#Downloading Brew applications
$DIR/2-set-up-packages.sh
