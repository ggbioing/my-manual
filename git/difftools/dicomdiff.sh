#!/usr/bin/env bash
t1=`mktemp` && `dcmdump $1 > $t1` && t2=`mktemp` && `dcmdump $2 > $t2` && 'C:\Program Files (x86)\WinMerge\WinMergeU.exe' $t1 $t2 && rm -f $t1 $t2