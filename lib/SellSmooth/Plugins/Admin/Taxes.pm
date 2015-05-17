package SellSmooth::Plugins::Admin::Taxes;

use strict;
use warnings;
use Dancer2;
use Dancer2::Plugin::Localization;
use Moose;
use SellSmooth::Core::Loaddataservice;
use Data::Dumper;
use SellSmooth::Core;
use YAML::XS qw/LoadFile/;
debug;

with 'SellSmooth::Plugin';

my $file = File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin_taxes.yml' );
open my $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/' . SellSmooth::Plugins::Admin->plugin_hash()->{path} . '/taxes';

get $path. '/list' => sub {

    template 'admin/list',
      { objects => SellSmooth::Core::Loaddataservice::list( 'SalesTax', {}, { page => 1 } ), },
      { layout => 'admin' };
};

get $path. '/edit/:number' => sub {
    my $ret = SellSmooth::Core::Loaddataservice::findByNumber( 'SalesTax', params->{number} );

    $ret->{economic_zone} = SellSmooth::Core::Loaddataservice::findById( 'EconomicZone', $ret->{economic_zone} );

    $ret->{rates} = SellSmooth::Core::Loaddataservice::list( 'SalesTaxRate', { sales_tax => $ret->{id} } );

    template 'admin/edit_tax',
      {
        object         => $ret,
        economic_zones => SellSmooth::Core::Loaddataservice::list('EconomicZone'),
      },
      { layout => 'admin' };
};

################################################################################
#######################             HOOKS                  #####################
################################################################################
hook before => sub {
    my $self = shift;
    my $client = SellSmooth::Base::Client->new( db_object => 'Client' )->find_by_id( session('client') );
    return redirect '/' . SellSmooth::Plugins::Admin->plugin_hash()->{path} . '/login' unless ($client);
};

hook before_template_render => sub {
    my $tokens   = shift;
    my $packname = __PACKAGE__;
    my $client   = SellSmooth::Base::Client->new( db_object => 'Client' )->find_by_id( session('client') );
    $tokens->{logged_in}   = ( defined $client ) ? 1 : 0;
    $tokens->{admin_path}  = $path;
    $tokens->{admin_conf}  = SellSmooth::Plugins::Admin->plugin_hash();
    $tokens->{locale_tags} = tags(language_country);
};

1;
