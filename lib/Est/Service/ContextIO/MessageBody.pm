package Est::Service::ContextIO::MessageBody;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Data::Validator;

use Est::Model::MessageBody;

sub fetch_by_hook {
    state $v = Data::Validator->new(
        client => 'Est::Service::ContextIO::Client',
        hook   => 'Est::Model::WebHook',
        opt    => +{ isa => 'HashRef', default => sub { +{} } },
    )->with(qw/Method SmartSequenced/);
    my ($class, $args) = $v->validate(@_);

    my $client = $args->{client};
    my $hook   = $args->{hook};
    my $opt    = $args->{opt};

    my $id         = $hook->{account_id};
    my $label      = $hook->{message_data}->{email_accounts}->[0]->{label};
    my $folder     = $hook->{message_data}->{email_accounts}->[0]->{folder};
    my $message_id = $hook->{message_data}->{email_message_id};

    my $action = "users/$id/email_accounts/$label/folders/$folder/messages/$message_id/body";

    Est::Model::MessageBody->new(
    +{
        content => $client->get($action, $opt),
    });
}

1;
