package Est::Model::WebHook;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Data::Validator;

sub new {
    state $v = Data::Validator->new(
        content => +{ isa => 'HashRef', default => sub { +{} } },
    )->with(qw/Method SmartSequenced/);
    my ($class, $args) = $v->validate(@_);

    my $self = +{ %{ $args->{content} } };
    bless($self, $class);
}

1;
