package SellSmooth::Plugins::Product;

use strict;
use warnings;
use Dancer2;
use Dancer2::Plugin::Localization;
use Moose;
use YAML::XS qw/LoadFile/;
use SellSmooth::Core;
use SellSmooth::Base::Product;
use SellSmooth::Base::OrganizationalUnit;
use SellSmooth::Base::CommodityGroup;
debug;

with 'SellSmooth::Plugin';

my $file = File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'product.yml' );
open my $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/product';

get $path. '/:number' => sub {
    my $product_hndl = SellSmooth::Base::Product->new( client => {}, db_object => 'Product' );
    my $org_hndl = SellSmooth::Base::OrganizationalUnit->new( client => {}, db_object => 'OrganizationalUnit' );
    my $com_group_hndl = SellSmooth::Base::CommodityGroup->new( client => {}, db_object => 'CommodityGroup' );
    my $object = $product_hndl->find_by_number( params->{number} );
    template 'product',
      {
        object           => $object,
        org              => $org_hndl->find_by_number(1),
        commodity_groups => $com_group_hndl->list( {}, { page => 1 } ),
      };
};

################################################################################
#######################             HOOKS                  #####################
################################################################################
hook before_template_render => sub {
    my $tokens   = shift;
    my $packname = __PACKAGE__;

#my $user     = ( defined $tokens->{user} ) ? $tokens->{user} : DataService::User::ViewUser->findById( session('client') );
#my $b        = Web::Desktop::token( $packname, $user, ( defined $user ) ? $user->{locale} : language_country, $tokens->{profile} );
#map { $tokens->{$_} = $b->{$_} } keys %$b;
    $tokens->{admin_path} = $path;
    $tokens->{locale_tags} = tags(language_country);

    #$tokens->{forum_active} = 'active ';
    #$tokens->{title}        = 'International Talk' if ( !defined $tokens->{title} );
};

1;
