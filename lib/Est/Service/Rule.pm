package Est::Service::Rule;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Data::Validator;

use Est::Service::Slack;
use Est::Config::Rule;

sub filter {
    state $v = Data::Validator->new(
        message  => 'Est::Model::Message',
        callback => 'CodeRef',
    )->with(qw/Method SmartSequenced/);
    my ($class, $args) = $v->validate(@_);

    Est::Config::Rule->filter(
        $args->{message},
        sub { $args->{callback}->(@_); }
    );
}

1;
