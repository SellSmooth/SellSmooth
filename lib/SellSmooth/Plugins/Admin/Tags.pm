package SellSmooth::Plugins::Admin::Tags;

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

my $file = File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin_tag.yml' );
open my $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/' . SellSmooth::Plugins::Admin->plugin_hash()->{path} . '/tags';

get $path. '/list' => sub {

    template 'admin/list',
      { objects => SellSmooth::Core::Loaddataservice::list( 'Tag', {}, { page => 1 } ), },
      { layout => 'admin' };
};

get $path. '/edit/:number' => sub {
    my $ret = SellSmooth::Core::Loaddataservice::findByNumber( 'Tag', params->{number} );

    $ret->{economic_zone} = SellSmooth::Core::Loaddataservice::findById( 'EconomicZone', $ret->{economic_zone} );

    $ret->{rates} = SellSmooth::Core::Loaddataservice::list( 'SalesTaxRate', { sales_tax => $ret->{id} } );

    template 'admin/edit',
      {
        object         => $ret,
        economic_zones => SellSmooth::Core::Loaddataservice::list('EconomicZone'),
      },
      { layout => 'admin' };
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
    $tokens->{admin_path}  = $path;
    $tokens->{admin_conf}  = SellSmooth::Plugins::Admin->plugin_hash();
    $tokens->{locale_tags} = tags(language_country);
};

1;
