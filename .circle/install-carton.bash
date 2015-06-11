#!/bin/bash

if type -p carton > /dev/null 2>&1; then
    exit
fi

cpanm Carton
