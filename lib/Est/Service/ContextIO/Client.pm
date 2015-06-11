package Est::Service::ContextIO::Client;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Data::Validator;
use Data::Dumper;

use URI;
use Net::OAuth;
use LWP::UserAgent;
use HTTP::Request::Common qw/ GET POST DELETE /;

use String::Random qw/ random_regex /;
use JSON qw/ decode_json /;

use Est::Service::ContextIO::Client::Exception;

sub new {
    my ($class, $args) = @_;

    my $self = +{
        oauth_key              => $args->{oauth_key},
        oauth_secret           => $args->{oauth_secret},
        oauth_signature_method => $args->{oauth_signature_method} // 'HMAC-SHA1',
        oauth_endpoint         => $args->{oauth_endpoint}         // 'https://api.context.io/lite/',
    };

    bless($self, $class);
}

sub get {
    state $v = Data::Validator->new(
        action => 'Str',
        opt    => { isa => 'HashRef', default => sub { +{} } },
    )->with(qw/Method SmartSequenced/);
    my ($self, $args) = $v->validate(@_);

    $self->request('GET', $args);
}

sub post {
    state $v = Data::Validator->new(
        action => 'Str',
        opt    => { isa => 'HashRef', default => sub { +{} } },
    )->with(qw/Method SmartSequenced/);
    my ($self, $args) = $v->validate(@_);

    $self->request('POST', $args);
}

sub delete {
    state $v = Data::Validator->new(
        action => 'Str',
        opt    => { isa => 'HashRef', default => sub { +{} } },
    )->with(qw/Method SmartSequenced/);
    my ($self, $args) = $v->validate(@_);

    $self->request('DELETE', $args);
}

sub request {
    state $v = Data::Validator->new(
        method => 'Str',
        action => 'Str',
        opt    => { isa => 'HashRef', default => sub { +{} } },
    )->with(qw/Method SmartSequenced/);
    my ($self, $args) = $v->validate(@_);

    my $method    = $args->{method};
    my $opt       = $args->{opt};

    my $oauth_req = $self->oauth_request($args);
    my $ua        = LWP::UserAgent->new;
    my $response  = $method eq 'GET'    ? $ua->request(GET    $oauth_req->to_url)       :
                    $method eq 'POST'   ? $ua->request(POST   $oauth_req->to_url, $opt) :
                    $method eq 'DELETE' ? $ua->request(DELETE $oauth_req->to_url)       : undef;

    if ($response->code >= 400 ||
        $response->header('Content-Type') !~ /json/)
    {
        Est::Service::ContextIO::Client::Exception->throw($response->content);
    }

    decode_json($response->content);
}

sub request_url {
    state $v = Data::Validator->new(
        method => 'Str',
        action => 'Str',
        opt    => { isa => 'HashRef', default => sub { +{} } },
    )->with(qw/Method SmartSequenced/);
    my ($self, $args) = $v->validate(@_);

    my $request_url = URI->new_abs($args->{action}, $self->{oauth_endpoint});

    $request_url->query_form($args->{opt}) if $args->{method} eq 'GET';
    $request_url->as_string;
}

sub oauth_request {
    state $v = Data::Validator->new(
        method => 'Str',
        action => 'Str',
        opt    => { isa => 'HashRef', default => sub { +{} } },
    )->with(qw/Method SmartSequenced/);
    my ($self, $args) = $v->validate(@_);

    my $oauth_req = Net::OAuth->request('consumer')->new(
        consumer_key     => $self->{oauth_key},
        consumer_secret  => $self->{oauth_secret},
        signature_method => $self->{oauth_signature_method},
        timestamp        => time,
        nonce            => $self->nonce,
        request_method   => $args->{method},
        request_url      => $self->request_url($args),
        extra_params     => $args->{method} eq 'POST' ? $args->{opt} : undef,
    );

    $oauth_req->sign;
    $oauth_req;
}

sub nonce {
    random_regex('[a-zA-Z0-9_]{32}');
}

1;
