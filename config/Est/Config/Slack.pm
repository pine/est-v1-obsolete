package Est::Config::Slack;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Config::ENV 'PLACK_ENV';

common +{
    test => 'https://hooks.slack.com/services/XXXXXXXXX/XXXXXXX/XXXXXXXXXXXXXXXX',
};

1;
