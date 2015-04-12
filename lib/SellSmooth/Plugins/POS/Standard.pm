package SellSmooth::Plugins::POS::Standard;

use strict;
use warnings;
use Dancer2;
use Moose;
use YAML::XS qw/LoadFile/;
use SellSmooth::Core::Loaddataservice;
use Data::Dumper;
use SellSmooth::Core;

with 'SellSmooth::Plugin';

my $file = File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin.yml' );
open my $rfh, '<', $file or die "$file $!";
my $admin_hash = LoadFile($file);
close $rfh;

$file =
  File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'pos_standard.yml' );
open $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/' . $admin_hash->{path} . '/pos_standard';

debug __PACKAGE__;

get $path => sub {
    my $products =
      SellSmooth::Core::Loaddataservice::list( 'Product', {}, { page => 1 } );
    foreach ( @{ $products->{content} } ) {
        $_->{prices} =
          SellSmooth::Core::Loaddataservice::list( 'ProductPrice',
            { product => $_->{id} } );
    }

    my $orgHndl = SellSmooth::Base::OrganizationalUnit->new( client => {} );
    template 'pos/index',
      {
        products         => $products,
        org              => $orgHndl->findByNumber(1),
        commodity_groups => SellSmooth::Core::Loaddataservice::list(
            'CommodityGroup', {}, { page => 1 }
        ),
      },
      { layout => 'pos' };
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
    $tokens->{admin_path} = '/pos_standard';

#$tokens->{forum_active} = 'active ';
#$tokens->{title}        = 'International Talk' if ( !defined $tokens->{title} );
};

1;
