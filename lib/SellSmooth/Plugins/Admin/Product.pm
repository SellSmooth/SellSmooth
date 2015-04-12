package SellSmooth::Plugins::Admin::Product;

use strict;
use warnings;
use Dancer2;
use Dancer2::Plugin::Ajax;
use Dancer2::Serializer::JSON;
use Moose;
use YAML::XS qw/LoadFile/;
use Data::Dumper;
use SellSmooth::Core;
use SellSmooth::Base::Prices;

with 'SellSmooth::Plugin';

my $file =
  File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin_product.yml' );
open my $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/' . SellSmooth::Plugins::Admin->plugin_hash()->{path} . '/product';

debug __PACKAGE__;

ajax $path. '/create' => sub {
    my $ret =
      { number => SellSmooth::Core::Loaddataservice::highestNumber('Product') };

    my $pr_list = SellSmooth::Core::Loaddataservice::list('PriceList');
    foreach (@$pr_list) {
        $_->{currency} =
          SellSmooth::Core::Loaddataservice::findById( 'Currency',
            $_->{currency} );
    }

    return template 'admin/edit_product',
      {
        object      => $ret,
        price_lists => $pr_list,
        sectors     => SellSmooth::Core::Loaddataservice::list('Sector'),
        assortments => SellSmooth::Core::Loaddataservice::list('Assortment'),
        commodity_groups =>
          SellSmooth::Core::Loaddataservice::list('CommodityGroup'),
      },
      { layout => undef };

    #return to_json( $ret, { utf8 => 1 } );
};

get $path. '/list' => sub {

    template 'admin/list',
      {
        objects => SellSmooth::Core::Loaddataservice::list(
            'Product', {}, { page => 1 }
        ),
      },
      { layout => 'admin' };
};

get $path. '/edit/:number' => sub {
    my $ret = SellSmooth::Core::Loaddataservice::findByNumber( 'Product',
        params->{number} );

    my $prices = SellSmooth::Base::Prices->new();
    $ret->{prices} = $prices->findByProduct($ret);
    $ret->{sector} =
      SellSmooth::Core::Loaddataservice::findById( 'Sector', $ret->{sector} );
    $ret->{commodity_group} =
      SellSmooth::Core::Loaddataservice::findById( 'CommodityGroup',
        $ret->{commodity_group} );
    $ret->{assortment} =
      SellSmooth::Core::Loaddataservice::findById( 'Assortment',
        $ret->{assortment} );

    my $pr_list = SellSmooth::Core::Loaddataservice::list('PriceList');
    foreach (@$pr_list) {
        $_->{currency} =
          SellSmooth::Core::Loaddataservice::findById( 'Currency',
            $_->{currency} );
    }

    template 'admin/edit_product',
      {
        object      => $ret,
        price_lists => $pr_list,
        sectors     => SellSmooth::Core::Loaddataservice::list('Sector'),
        assortments => SellSmooth::Core::Loaddataservice::list('Assortment'),
        commodity_groups =>
          SellSmooth::Core::Loaddataservice::list('CommodityGroup'),
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
    $tokens->{admin_path} = '/product';
    $tokens->{admin_conf} = SellSmooth::Plugins::Admin->plugin_hash();

};

1;
