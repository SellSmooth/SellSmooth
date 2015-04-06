package SellSmooth::Plugins::Admin::Currency;

use strict;
use warnings;
use Dancer2;
use Moose;
use YAML::XS qw/LoadFile/;

use SellSmooth::Core;

with 'SellSmooth::Plugin';

my $file = File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin.yml' );
open my $rfh, '<', $file or die "$file $!";
my $admin_hash = LoadFile($file);
close $rfh;

$file =
  File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin_currency.yml' );
open $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/' . $admin_hash->{path} . '/currency';

debug __PACKAGE__;

get $path. '/list' => sub {

    template 'admin/list',
      {
        objects => SellSmooth::Core::Loaddataservice::list(
            'Currency', {}, { page => 1 }
        ),
      },
      { layout => 'admin' };
};

get $path. '/edit/:number' => sub {
    template 'admin/edit',
      {
        object => SellSmooth::Core::Loaddataservice::findByNumber(
            'Currency', params->{number}
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
    $tokens->{admin_path} = '/currency';

#$tokens->{forum_active} = 'active ';
#$tokens->{title}        = 'International Talk' if ( !defined $tokens->{title} );
};

1;
