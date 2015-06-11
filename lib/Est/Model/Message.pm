package Est::Model::Message;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Data::Validator;

sub new {
    state $v = Data::Validator->new(
        hook => 'Est::Model::WebHook',
        body => 'Est::Model::MessageBody',
    )->with(qw/Method SmartSequenced/);
    my ($class, $args) = $v->validate(@_);


    my $self = +{
        hook => $args->{hook},
        body => $args->{body},
    };

    bless($self, $class);
}

sub from {
    shift->{hook}->{message_data}->{addresses}->{from}->{email};
}

sub to {
    map {
        $_->{email};
    } @{ shift->{hook}->{message_data}->{addresses}->{to} };
}

sub subject {
    shift->{hook}->{message_data}->{subject};
}

sub body {
    my $self = shift;

    my $bodies = $self->{body}->{bodies};

    my @text   = grep { $_->{type} =~ /^text\/plain/ } @$bodies;
    my @html   = grep { $_->{type} =~ /^(?:text|application)\/html/ } @$bodies;

    return $text[0]->{content} if @text;
    return $html[0]->{content} if @html;
    return '';
}

1;
