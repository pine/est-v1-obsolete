package Est::Config::ContextIO;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Config::ENV 'PLACK_ENV';

common +{
    oauth_key    => '',
    oauth_secret => '',
};

1;
