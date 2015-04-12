package SellSmooth::Plugins::Admin::Taxes;

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
  File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin_taxes.yml' );
open my $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/' . SellSmooth::Plugins::Admin->plugin_hash()->{path} . '/taxes';

debug __PACKAGE__;

get $path. '/list' => sub {

    template 'admin/list',
      {
        objects => SellSmooth::Core::Loaddataservice::list(
            'SalesTax', {}, { page => 1 }
        ),
      },
      { layout => 'admin' };
};

get $path. '/edit/:number' => sub {
    my $ret = SellSmooth::Core::Loaddataservice::findByNumber( 'SalesTax',
        params->{number} );

    $ret->{economic_zone} =
      SellSmooth::Core::Loaddataservice::findById( 'EconomicZone',
        $ret->{economic_zone} );

    $ret->{rates} = SellSmooth::Core::Loaddataservice::list( 'SalesTaxRate',
        { sales_tax => $ret->{id} } );

    template 'admin/edit_tax',
      {
        object => $ret,
        economic_zones =>
          SellSmooth::Core::Loaddataservice::list('EconomicZone'),
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
    $tokens->{admin_path} = '/taxes';
    $tokens->{admin_conf} = SellSmooth::Plugins::Admin->plugin_hash();
};

1;
