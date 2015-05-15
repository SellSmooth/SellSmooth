package SellSmooth::Plugins::Admin;

use strict;
use warnings;
use Dancer2;
use Moose;
use YAML::XS qw/LoadFile/;

use SellSmooth::Core;

with 'SellSmooth::Plugin';

my $plugin_hash = load_config();
my $path        = '/' . $plugin_hash->{path};

debug __PACKAGE__;

get $path => sub {

    template 'admin/index', {}, { layout => 'admin' };
};

get $path . '/login' => sub {

    template 'admin/index', {}, { layout => 'admin' };
};

post $path . '/login' => sub {

    template 'admin/index', {}, { layout => 'admin' };
};

sub load_config {
    my $file =
      File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin.yml' );
    open my $rfh, '<', $file or die "$file $!";
    my $ret = LoadFile($file);
    close $rfh;
    return $ret;
}

sub plugin_hash {
    return $plugin_hash if ( defined $plugin_hash );
    $plugin_hash = load_config();
    return $plugin_hash;
}

################################################################################
#######################             HOOKS                  #####################
################################################################################
hook before_template_render => sub {
    my $tokens   = shift;
    my $packname = __PACKAGE__;

#my $user     = ( defined $tokens->{user} ) ? $tokens->{user} : DataService::User::ViewUser->findById( session('user') );
#my $b        = Web::Desktop::token( $packname, $user, ( defined $user ) ? $user->{locale} : language_country, $tokens->{profile} );
#map { $tokens->{$_} = $b->{$_} } keys %$b;
    $tokens->{admin_path} = '/zones';
    $tokens->{admin_conf} = plugin_hash();
    $tokens->{locale_tags} = tags(language_country);
};

1;
