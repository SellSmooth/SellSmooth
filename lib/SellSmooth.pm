package SellSmooth;

use strict;
use warnings;
use Data::Dumper;
use Module::Load;
use Dancer2;

use SellSmooth::Core;
use SellSmooth::Plugins;
use SellSmooth::Core::Loaddataservice;

our $VERSION = '0.1.0';

my $plg = SellSmooth::Plugins->new();
load $_ foreach @{ $plg->enabled() };

get '/' => sub {
    return redirect '/install' unless ( SellSmooth::Core->check_install($plg) );

    template 'index',
      {
        products => SellSmooth::Core::Loaddataservice::list(
            'Product', {}, { page => 1 }
        ),
        commodity_groups => SellSmooth::Core::Loaddataservice::list(
            'CommodityGroup', {}, { page => 1 }
        ),
      };
};

1;
