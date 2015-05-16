package SellSmooth::Plugins::Admin::Product;

use strict;
use warnings;
use Dancer2;
use Dancer2::Plugin::Localization;
use Dancer2::Plugin::Ajax;
use Dancer2::Serializer::JSON;
use Moose;
use Data::Dumper;
use SellSmooth::Core;
use SellSmooth::Base::Prices;
use SellSmooth::Base::Sector;
use YAML::XS qw/LoadFile/;
debug;

with 'SellSmooth::Plugin';

my $file = File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin_product.yml' );
open my $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/' . SellSmooth::Plugins::Admin->plugin_hash()->{path} . '/product';

ajax $path. '/create' => sub {
    my $price_list_hndl = SellSmooth::Base::PriceList->new( db_object => 'PriceList' );

    return template 'admin/edit_product',
      {
        object      => { number => SellSmooth::Core::Loaddataservice::highestNumber('Product') },
        price_lists => $price_list_hndl->list(),
        sectors          => SellSmooth::Core::Loaddataservice::list('Sector'),
        assortments      => SellSmooth::Core::Loaddataservice::list('Assortment'),
        commodity_groups => SellSmooth::Core::Loaddataservice::list('CommodityGroup'),
      },
      { layout => undef };

    #return to_json( $ret, { utf8 => 1 } );
};

get $path. '/list' => sub {
    my $product_hndl = SellSmooth::Base::Product->new( client => {}, db_object => 'Product' );

    template 'admin/list', { objects => $product_hndl->list( {}, { page => 1 } ), }, { layout => 'admin' };
};

get $path. '/edit/:number' => sub {
    my $product_hndl = SellSmooth::Base::Product->new( client => {}, db_object => 'Product' );
    my $price_list_hndl = SellSmooth::Base::PriceList->new( db_object => 'PriceList' );

    template 'admin/edit_product',
      {
        object           => $product_hndl->find_by_number( params->{number} ),
        price_lists      => $price_list_hndl->list(),
        sectors          => SellSmooth::Core::Loaddataservice::list('Sector'),
        assortments      => SellSmooth::Core::Loaddataservice::list('Assortment'),
        commodity_groups => SellSmooth::Core::Loaddataservice::list('CommodityGroup'),
      },
      { layout => 'admin' };
};

################################################################################
#######################             HOOKS                  #####################
################################################################################
hook before => sub {
    my $self   = shift;
    debug Dumper($self);
    my $user_hndl = SellSmooth::Base::User->new( client => {}, db_object => 'User' );
    my $user = $user_hndl->find_by_id( session('client') );
    return redirect '/' . SellSmooth::Plugins::Admin->plugin_hash()->{path} . '/login' unless ($user);
};

hook before_template_render => sub {
    my $tokens   = shift;
    my $packname = __PACKAGE__;

#my $user     = ( defined $tokens->{user} ) ? $tokens->{user} : DataService::User::ViewUser->findById( session('client') );
#my $b        = Web::Desktop::token( $packname, $user, ( defined $user ) ? $user->{locale} : language_country, $tokens->{profile} );
#map { $tokens->{$_} = $b->{$_} } keys %$b;
    $tokens->{admin_path}  = $path;
    $tokens->{admin_conf}  = SellSmooth::Plugins::Admin->plugin_hash();
    $tokens->{locale_tags} = tags(language_country);

};

1;
