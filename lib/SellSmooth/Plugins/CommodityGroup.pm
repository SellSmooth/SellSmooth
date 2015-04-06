package SellSmooth::Plugins::CommodityGroup;

use strict;
use warnings;
use Dancer2;
use Moose;
use YAML::XS qw/LoadFile/;
use SellSmooth::Core::Loaddataservice;
use Data::Dumper;
use SellSmooth::Core;

with 'SellSmooth::Plugin';

my $file = File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d',
    'commodity_group.yml' );
open my $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/commodity_group';

debug __PACKAGE__;

get $path. '/:number' => sub {
    my $object =
      SellSmooth::Core::Loaddataservice::findByNumber( 'CommodityGroup',
        params->{number} );

    my $products = SellSmooth::Core::Loaddataservice::list(
        'Product',
        { commodity_group => $object->{id} },
        { page            => 1 }
    );
    foreach ( @{ $products->{content} } ) {
        $_->{prices} =
          SellSmooth::Core::Loaddataservice::list( 'ProductPrice',
            { product => $_->{id} } );
    }
    my $orgHndl = SellSmooth::Base::OrganizationalUnit->new( client => {} );
    template 'index',
      {
        object           => $object,
        products         => $products,
        org              => $orgHndl->findByNumber(1),
        commodity_groups => SellSmooth::Core::Loaddataservice::list(
            'CommodityGroup', {}, { page => 1 }
        ),
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
    $tokens->{admin_path} = '/commodity_group';

#$tokens->{forum_active} = 'active ';
#$tokens->{title}        = 'International Talk' if ( !defined $tokens->{title} );
};

1;
