package SellSmooth::Plugins::Products;

use strict;
use warnings;
use Dancer2;
use Moose;

with 'SellSmooth::Plugin';

debug __PACKAGE__;

get '/' => sub {
    template 'index';
};

get '/install' => sub {

    template 'install/index';
};

1;
