package Est::Config::Rule::All;

use strict;
use warnings;
use utf8;
use 5.18.2;

sub filter {
    my ($class, $message, $cb) = @_;

    my $text = <<EOF;
Message Received !!

from: @{[ $message->from ]}
to: @{[ $message->to ]}
subject: @{[ $message->subject ]}
body: @{[ $message->body ]}
EOF

    $cb->(
        +{
            id   => 'test',
            text => $text,
        });
}

1;
