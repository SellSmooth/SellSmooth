package SellSmooth::Plugins::Admin::Login;

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

my $file = File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin.yml' );
open my $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/' . $plugin_hash->{path} . '/login';

get $path => sub {
    app->destroy_session;
    template 'admin/login', {}, { layout => 'admin' };
};

post $path => sub {
    my $user_hndl = SellSmooth::Base::User->new( client => {}, db_object => 'User' );
    my $lang      = language_country;
    my $user      = $user_hndl->find_by_email( params->{'xxx'} );
    my $err       = undef;

    if ( defined $user && $user ne '' ) {
        if ( SellSmooth::Core::Password->verify( $user_hndl->find_by_id( $user->{id} ), params->{'yyy'} ) ) {
            $user_hndl->update_last_login($user);
            $user_hndl->update_last_idle_remind($user);
            session 'client' => $user->{client};
            return redirect $path;
        }
        else { $err = 'error_invalid_passwd'; }
    }
    else { $err = 'error_invalid_user'; }

    template 'admin/login', { error => $err }, { layout => 'admin' };
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
    $tokens->{admin_conf}  = $plugin_hash;
    $tokens->{locale_tags} = tags(language_country);
};

1;
