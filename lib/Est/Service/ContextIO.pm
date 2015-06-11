package Est::Service::ContextIO;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Data::Validator;

use Est::Config::ContextIO;
use Est::Service::WebHook;
use Est::Service::ContextIO::Client;
use Est::Service::ContextIO::WebHook;
use Est::Service::ContextIO::MessageBody;
use Est::Model::Message;

sub client {
    state $client;
    state $v = Data::Validator->new->with(qw/Method/);
    my ($class, $args) = $v->validate(@_);

    $client //= $class->new_client;
}

sub new_client {
    state $v = Data::Validator->new->with(qw/Method/);
    my ($class, $args) = $v->validate(@_);

    my $oauth_key    = Est::Config::ContextIO->param('oauth_key');
    my $oauth_secret = Est::Config::ContextIO->param('oauth_secret');

    Est::Service::ContextIO::Client->new(
        +{
            oauth_key    => $oauth_key,
            oauth_secret => $oauth_secret,
        });
}

sub fetch_message {
    state $v = Data::Validator->new(
        body => 'Str',
    )->with(qw/Method/);
    my ($class, $args) = $v->validate(@_);

    my $client = $class->client;
    my $hook   = Est::Service::ContextIO::WebHook->hooked($args->{body});
    my $body   = Est::Service::ContextIO::MessageBody->fetch_by_hook($client, $hook);

    Est::Model::Message->new($hook, $body);
}

1;
