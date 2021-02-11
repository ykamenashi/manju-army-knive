#!/bin/bash


### dependency check

if [ "$#" -ne 2 ] ; then
  if [ "$#" -eq 1 ] ; then
    TARGET_FILE_NAME=$1
  fi
else
  TARGET_DIR="$1"
  TARGET_FILE_NAME="$2"
fi


command -v find > /dev/null
if [ "$?" -ne 0 ] ; then
  echo "err: find not found. quit."
  exit 254
fi

command -v cp > /dev/null
if [ "$?" -ne 0 ] ; then
  echo "err: cp not found. quit."
  exit 254
fi

### main search routine

pushd "$TARGET_DIR" > /dev/null
find . -type d -maxdepth 1 > /dev/null
if [ "$?" -ne 0 ] ; then
  echo "no directories found. quit."
  popd > /dev/null
  exit 0
fi

DIR_LIST=$(find . -type d -maxdepth 1)

for D in "$DIR_LIST"
do
  ls -ld "$D/$TARGET_FILE_NAME" > /dev/null 2>&1
  if [ "$?" -ne 0 ] ; then
    NO_FILE_LIST=$(echo $D; echo '';echo $NO_FILE_LIST;)
  fi
done
echo "$TARGET_DIR/$D/$TARGET_FILE_NAME"

popd > /dev/null

## ask you okay to copy

exit 0
