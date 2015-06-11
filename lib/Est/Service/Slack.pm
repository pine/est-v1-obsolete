package Est::Service::Slack;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Data::Validator;
use WebService::Slack::IncomingWebHook;

use Est::Config::Slack;

sub slack {
    state $v = Data::Validator->new(
        id => 'Str',
    )->with(qw/Method SmartSequenced/);
    my ($class, $args) = $v->validate(@_);

    state $instances = +{};

    my $id = $args->{id};
    unless ($instances->{$id}) {
        my $url   = Est::Config::Slack->param($id);
        my $slack = WebService::Slack::IncomingWebHook->new( webhook_url => $url );

        $instances->{$id} = $slack;
    }

    $instances->{$id};
}

sub post {
    state $v = Data::Validator->new(
        id       => 'Str',
        username => +{ isa => 'Str', default => undef },
        text     => 'Str',
    )->with(qw/Method SmartSequenced/);
    my ($class, $args) = $v->validate(@_);

    my $slack = $class->slack($args->{id});

    $slack->post(
        username => $args->{username},
        text     => $args->{text},
    );
}

1;
