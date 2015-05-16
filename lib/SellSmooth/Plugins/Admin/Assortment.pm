package SellSmooth::Plugins::Admin::Assortment;

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

my $file = File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin_assortment.yml' );
open my $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/' . SellSmooth::Plugins::Admin->plugin_hash()->{path} . '/assortments';



get $path. '/list' => sub {
    my $assortment_hndl = SellSmooth::Base::Assortment->new( client => {}, db_object => 'Assortment' );

    template 'admin/list', { objects => $assortment_hndl->list( {}, { page => 1 } ), }, { layout => 'admin' };
};

get $path. '/edit/:number' => sub {
    my $assortment_hndl = SellSmooth::Base::Assortment->new( client => {}, db_object => 'Assortment' );
    template 'admin/edit', { object => $assortment_hndl->find_by_number( params->{number} ), }, { layout => 'admin' };
};

################################################################################
#######################             HOOKS                  #####################
################################################################################
hook before => sub {
    my $user = DataService::User::ViewUser->findById( session('client') );
    return redirect '/' unless ($user);
};

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
