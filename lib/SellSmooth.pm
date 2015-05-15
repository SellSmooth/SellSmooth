package SellSmooth;

use strict;
use warnings;
use Data::Dumper;
use Module::Load;
use Dancer2;
use Dancer2::Plugin::Localization;
use SellSmooth::Core;
use SellSmooth::Plugins;
use SellSmooth::Core::Loaddataservice;
use SellSmooth::Base::OrganizationalUnit;
use SellSmooth::Base::Product;
use SellSmooth::Base::CommodityGroup;

our $VERSION = '0.1.0';

my $plg = SellSmooth::Plugins->new();
load $_ foreach @{ $plg->enabled() };

get '/' => sub {
    return redirect '/install' unless ( SellSmooth::Core->check_install($plg) );

    my $org_hndl     = SellSmooth::Base::OrganizationalUnit->new( client => {}, db_object => 'OrganizationalUnit' );
    my $product_hndl = SellSmooth::Base::Product->new( client => {}, db_object => 'Product' );
    my $com_group_hndl = SellSmooth::Base::CommodityGroup->new( db_object => 'CommodityGroup' );

    template 'index',
      {
        products         => $product_hndl->list_refer( {}, { page => 1 } ),
        org              => $org_hndl->find_by_number(1),
        commodity_groups => $com_group_hndl->list( {}, { page => 1 } ),
      };
};

hook before_template_render => sub {
    my $tokens   = shift;
    my $packname = __PACKAGE__;
    $tokens->{locale_tags} = tags(language_country);
};

dance;

1;
