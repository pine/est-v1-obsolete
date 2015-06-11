package Est::Web::Dispatcher;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Module::Find;
use Amon2::Web::Dispatcher::RouterBoom;

useall 'Est::Web::C';
base 'Est::Web::C';

post '/webhook' => 'WebHook#hooked';

1;
