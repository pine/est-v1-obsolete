package Est::Web::C::WebHook;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Log::Minimal;

use Est::Service::ContextIO;
use Est::Service::Rule;

sub hooked {
    my ($class, $c) = @_;

    infof('Hooked');

    my $body    = $c->request->content;
    my $message = Est::Service::ContextIO->fetch_message(+{ body => $body });

    Est::Service::Rule->filter(
        $message,
        sub { Est::Service::Slack->post(@_); }
    );

    return $c->create_response(
        200,
        +{ 'Content-Type' => 'text/plain' },
        [ 'OK' ]
    );
}

1;
