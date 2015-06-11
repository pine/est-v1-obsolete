package Est::Service::ContextIO::WebHook;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Data::Validator;
use JSON qw/ decode_json /;

use Est::Model::WebHook;

sub hooked {
    state $v = Data::Validator->new(
        body => 'Str',
    )->with(qw/Method SmartSequenced/);
    my ($self, $args) = $v->validate(@_);

    my $content = decode_json($args->{body});
    Est::Model::WebHook->new($content);
}

1;
