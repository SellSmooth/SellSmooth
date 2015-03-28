package SellSmooth::Plugins::Install;

use strict;
use warnings;
use Dancer2;
use Moose;

with 'SellSmooth::Plugin';

debug __PACKAGE__;

get '/install' => sub {

    template 'install/index';
};

1;
