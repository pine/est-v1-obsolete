package Est::Bootstrap;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Data::Validator;

sub run {
    state $v = Data::Validator->new->with(qw/Method/);
    my ($class, $args) = $v->validate(@_);

    say 'Please register WebHook URL in Context.IO by manually';
    say 'See Context.IO Console: https://console.context.io/';
}

1;
