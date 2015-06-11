#!/bin/bash

echo 'eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)' >> ~/.bashrc

if type -p cpanm > /dev/null 2>&1; then
    exit
fi

mkdir -p $HOME/perl5/bin/

curl -L cpanmin.us > $HOME/perl5/bin/cpanm
chmod +x $HOME/perl5/bin/cpanm

cpanm --local-lib=~/perl5 local::lib

