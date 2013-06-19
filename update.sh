#!/bin/sh

make &> /dev/null && git commit -a -m "`date +'%A %B %d, %Y'`" &> /dev/null
