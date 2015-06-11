use strict;
use warnings;
use utf8;
use 5.18.2;

use t::Util;
use Test::More;

use Est::Config::Rule::Amazon;

subtest is_amazon => sub {
    ok( Est::Config::Rule::Amazon->is_amazon('delivery-notification@amazon.co.jp') );
    ok( not Est::Config::Rule::Amazon->is_amazon('noreply@github.com') );
};

subtest find_item_list => sub {
    my $body = <<EOF;
今回発送した商品は以下のとおりです。
------------------------------
数量商品発送済み
------------------------------
1ひまわりさん (MFコミックス アライブシリーズ) 1  ご指定のコンビニ店名と住所は以下のとおりです。
EOF

    ok( Est::Config::Rule::Amazon->find_item_list($body) =~ /ひまわりさん/);
    ok( Est::Config::Rule::Amazon->find_item_list($body) !~ /発送済み/);
};

done_testing;
