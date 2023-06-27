#! /bin/bash


if [[ $OSTYPE == 'darwin'* ]]; then
  LOCAL=$(md5 $(cat constant.txt) | awk '{ print $4}' | tr -d "\n" | md5)
else
  LOCAL=$(md5sum $(cat constant.txt) | awk '{ print $1}' | tr -d "\n" | md5sum | awk '{ print $1 }')
fi

CACHEBUSTER=$(openssl rand -hex 16)
REMOTE=$(curl https://gist.githubusercontent.com/mortimr/089368eba26acbc203ffe3f3a807a268/raw/test_checksum?cachebust=${CACHEBUSTER} 2> /dev/null)

echo "LOCAL  = $LOCAL"
echo "REMOTE = $REMOTE"
echo "CACHEBUSTER = $CACHEBUSTER"

if [ "$LOCAL" = "$REMOTE" ]; then
  echo "good"
else
  echo "invalid"
  exit 1
fi