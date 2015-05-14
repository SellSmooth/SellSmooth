package SellSmooth::Plugins::Product;

use strict;
use warnings;
use Dancer2;
use Moose;
use YAML::XS qw/LoadFile/;
use SellSmooth::Core::Loaddataservice;
use Data::Dumper;
use SellSmooth::Core;
use SellSmooth::Base::Sector;

with 'SellSmooth::Plugin';

my $file = File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'product.yml' );
open my $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/product';

debug __PACKAGE__;

get $path. '/:number' => sub {
    my $object =
      SellSmooth::Core::Loaddataservice::findByNumber( 'Product', params->{number} );

    $object->{prices} =
      SellSmooth::Core::Loaddataservice::list( 'ProductPrice',
        { product => $object->{id} } );
    my $sector_handler = SellSmooth::Base::Sector->new();
    $object->{sector} = $sector_handler->load_full( $object->{sector} );
    $object->{commodity_group} =
      SellSmooth::Core::Loaddataservice::findById( 'CommodityGroup',
        $object->{commodity_group} );
    $object->{assortment} =
      SellSmooth::Core::Loaddataservice::findById( 'Assortment', $object->{assortment} );

    my $orgHndl = SellSmooth::Base::OrganizationalUnit->new( client => {} );
    $object->{image} = 'products/'.$object->{number}.'.jpg';
    #debug Dumper $object;
    template 'product',
      {
        object => $object,
        org    => $orgHndl->find_by_number(1),
        commodity_groups =>
          SellSmooth::Core::Loaddataservice::list( 'CommodityGroup', {}, { page => 1 } ),
      };
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
    $tokens->{admin_path} = $path;

    #$tokens->{forum_active} = 'active ';
    #$tokens->{title}        = 'International Talk' if ( !defined $tokens->{title} );
};

1;
