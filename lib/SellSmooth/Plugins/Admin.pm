package SellSmooth::Plugins::Admin;

use strict;
use warnings;
use Dancer2;
use Moose;
use YAML::XS qw/LoadFile/;

use SellSmooth::Core;

with 'SellSmooth::Plugin';

my $admin_file =
  File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin.yml' );
open my $rfh, '<', $admin_file or die "$admin_file $!";
my $plugin_hash = LoadFile($admin_file);
close $rfh;
my $path = '/' . $plugin_hash->{path};

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

1;
