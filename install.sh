#!/bin/bash -v

if [ -e ./rc ] ; then
    sudo cp -nv rc /usr/bin
fi
