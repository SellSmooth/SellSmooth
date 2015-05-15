package SellSmooth::Plugins::Admin::CommodityGroup;

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
    'admin_commodity_group.yml' );
open my $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path =
  '/' . SellSmooth::Plugins::Admin->plugin_hash()->{path} . '/commodity_group';

debug __PACKAGE__;

get $path. '/list' => sub {

    template 'admin/list',
      {
        objects => SellSmooth::Core::Loaddataservice::list(
            'CommodityGroup', {}, { page => 1 }
        ),
      },
      { layout => 'admin' };
};

get $path. '/edit/:number' => sub {
    template 'admin/edit',
      {
        object => SellSmooth::Core::Loaddataservice::findByNumber(
            'CommodityGroup', params->{number}
        ),
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
    $tokens->{admin_path} = $path;
    $tokens->{admin_conf} = SellSmooth::Plugins::Admin->plugin_hash();
    $tokens->{locale_tags} = tags(language_country);
};

1;
