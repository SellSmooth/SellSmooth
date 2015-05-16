package SellSmooth::Plugins::Admin;

use strict;
use warnings;
use Data::Dumper;
use Dancer2;
use Dancer2::Plugin::Localization;
use Moose;
use YAML::XS qw/LoadFile/;
use SellSmooth::Core;
use SellSmooth::Base::User;

use SellSmooth::Plugins::Admin::Login;
debug;

with 'SellSmooth::Plugin';

my $plugin_hash = load_config();
my $path        = '/' . $plugin_hash->{path};

get $path => sub {
    template 'admin/index', {}, { layout => 'admin' };
};

sub load_config {
    my $file = File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin.yml' );
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
hook before => sub {
    my $self = shift;
    debug Dumper($self);
    my $user_hndl = SellSmooth::Base::User->new( client => {}, db_object => 'User' );
    my $user = $user_hndl->find_by_id( session('client') );
    return redirect '/' . $plugin_hash->{path} . '/login' unless ($user);
};

hook before_template_render => sub {
    my $tokens   = shift;
    my $packname = __PACKAGE__;

#my $user     = ( defined $tokens->{user} ) ? $tokens->{user} : DataService::User::ViewUser->findById( session('client') );
#my $b        = Web::Desktop::token( $packname, $user, ( defined $user ) ? $user->{locale} : language_country, $tokens->{profile} );
#map { $tokens->{$_} = $b->{$_} } keys %$b;
    $tokens->{admin_path}  = $path;
    $tokens->{admin_conf}  = plugin_hash();
    $tokens->{locale_tags} = tags(language_country);
};

1;

__END__
