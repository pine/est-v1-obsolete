use strict;
use warnings;
use utf8;
use 5.18.2;

use t::Util;
use Test::More;

use Est::Config::ContextIO;

subtest oauth_key => sub {
    ok( length Est::Config::ContextIO->param('oauth_key') > 0 );
};

subtest oauth_secret => sub {
    ok( length Est::Config::ContextIO->param('oauth_secret') > 0 );
};

done_testing;
