# Amon 2
requires 'Amon2', '6.10';
requires 'Crypt::CBC';
requires 'Crypt::Rijndael';
requires 'DBD::SQLite', '1.33';
requires 'HTML::FillInForm::Lite', '1.11';
requires 'HTTP::Session2', '1.03';
requires 'Module::Functions', '2';
requires 'Plack::Middleware::ReverseProxy', '0.09';
requires 'Router::Boom', '0.06';
requires 'Starlet', '0.20';
requires 'Teng', '0.18';
requires 'Test::WWW::Mechanize::PSGI';
requires 'Text::Xslate', '2.0009';
requires 'Time::Piece', '1.20';
requires 'Data::Validator', '1.07';
requires 'Module::Find', '0.13';
requires 'JSON', '2.50';
requires 'perl', '5.010_001';
requires 'Server::Starter', '0.30';

# Validator
requires 'Data::Validator', '1.07';

# Logging
requires 'Log::Minimal', '0.19';

# OAuth / HTTP
requires 'URI', '1.67';
requires 'Net::OAuth', '0.28';
requires 'String::Random', '0.28';
requires 'LWP::UserAgent', '6.13';
requires 'LWP::Protocol::https', '6.0.6';
requires 'Exception::Tiny', '0.2.1';

# Slack
requires 'WebService::Slack::IncomingWebHook', '0.01';

# Config
requires 'Config::ENV', '0.13';

on configure => sub {
    requires 'Module::Build', '0.38';
    requires 'Module::CPANfile', '0.9010';
};

on test => sub {
    requires 'Test::More', '0.98';
};
