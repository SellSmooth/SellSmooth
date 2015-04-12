package SellSmooth::Plugins::Admin::OrganizationalUnit;

use strict;
use warnings;
use Dancer2;
use Moose;
use YAML::XS qw/LoadFile/;
use SellSmooth::Core::Loaddataservice;
use Data::Dumper;
use SellSmooth::Core;

with 'SellSmooth::Plugin';

my $file =
  File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d',
    'admin_organizational_unit.yml' );
open my $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/' . SellSmooth::Plugins::Admin->plugin_hash()->{path} . '/organizational_units';

debug __PACKAGE__;

get $path. '/list' => sub {

    template 'admin/list',
      {
        objects => SellSmooth::Core::Loaddataservice::list(
            'OrganizationalUnit', {}, { page => 1 }
        ),
      },
      { layout => 'admin' };
};

get $path. '/edit/:number' => sub {
    my $ret =
      SellSmooth::Core::Loaddataservice::findByNumber( 'OrganizationalUnit',
        params->{number} );

    $ret->{economic_zone} =
      SellSmooth::Core::Loaddataservice::findById( 'EconomicZone',
        $ret->{economic_zone} );

    $ret->{price_list} =
      SellSmooth::Core::Loaddataservice::findById( 'PriceList',
        $ret->{price_list} );

    $ret->{parent} =
      SellSmooth::Core::Loaddataservice::findById( 'OrganizationalUnit',
        $ret->{parent} );

    $ret->{assortments} =
      SellSmooth::Core::Loaddataservice::list( 'OrgAssortment',
        { org => $ret->{id} } );
    $_->{assortment} =
      SellSmooth::Core::Loaddataservice::findById( 'Assortment',
        $_->{assortment} )
      foreach @{ $ret->{assortments} };
    
    my $pr_list = SellSmooth::Core::Loaddataservice::list('PriceList');
    foreach (@$pr_list) {
        $_->{currency} =
          SellSmooth::Core::Loaddataservice::findById( 'Currency',
            $_->{currency} );
    }
    template 'admin/edit_organizational_unit',
      {
        object      => $ret,
        price_lists => $pr_list,
        economic_zones =>
          SellSmooth::Core::Loaddataservice::list('EconomicZone'),
        assortments => SellSmooth::Core::Loaddataservice::list('Assortment'),
        org => SellSmooth::Core::Loaddataservice::list('OrganizationalUnit'),
      },
      { layout => 'admin' };
};

################################################################################
#######################             HOOKS                  #####################
################################################################################
hook before_template_render => sub {
    my $tokens   = shift;
    my $packname = __PACKAGE__;

#my $user     = ( defined $tokens->{user} ) ? $tokens->{user} : DataService::User::ViewUser->findById( session('user') );
#my $b        = Web::Desktop::token( $packname, $user, ( defined $user ) ? $user->{locale} : language_country, $tokens->{profile} );
#map { $tokens->{$_} = $b->{$_} } keys %$b;
    $tokens->{admin_path} = '/organizational_units';
    $tokens->{admin_conf} = SellSmooth::Plugins::Admin->plugin_hash();
};

1;
