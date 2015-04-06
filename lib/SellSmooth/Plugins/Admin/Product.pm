package SellSmooth::Plugins::Admin::Product;

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
  File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'admin_product.yml' );
open $rfh, '<', $file or die "$file $!";
my $plugin_hash = LoadFile($file);
close $rfh;

my $path = '/' . $admin_hash->{path} . '/product';

debug __PACKAGE__;

get $path. '/list' => sub {

    template 'admin/list',
      {
        objects => SellSmooth::Core::Loaddataservice::list(
            'Product', {}, { page => 1 }
        ),
      },
      { layout => 'admin' };
};

get $path. '/edit/:number' => sub {

    template 'admin/edit', {}, { layout => 'admin' };
};

1;
