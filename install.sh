#!/bin/bash -v

if [ -e ./rc ] ; then
    sudo cp -nv rc /usr/bin
    sudo chmod ugo+x /usr/bin/rc
fi
