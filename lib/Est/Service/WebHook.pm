package Est::Service::WebHook;

use strict;
use warnings;
use utf8;
use 5.18.2;

use URI;

use Est::Config;

sub uri {
    state $v = Data::Validator->new->with(qw/Method/);
    my ($class, $args) = $v->validate(@_);

    my $base_uri = Est::Config->param('base_uri');
    URI->new_abs('/webhook', $base_uri)->as_string;
}

1;
