package Est::Config::Rule;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Module::Find;
useall 'Est::Config::Rule';

sub filter {
    my $class = shift;

    Est::Config::Rule::All->filter(@_);
}

1;
