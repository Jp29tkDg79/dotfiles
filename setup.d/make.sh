#!/bin/sh

for p in $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $ZDOTDIR
do
  echo $p
  [[ ! -d $p ]] && mkdir -p $p
done

