package SellSmooth;

use strict;
use warnings;
use Data::Dumper;
use Module::Load;
use Dancer2;

use SellSmooth::Plugins;

our $VERSION = '0.1.0';

my $plugins = SellSmooth::Plugins->new();
debug Dumper( $plugins->plugins() );
load $_ foreach @{ $plugins->plugins() };

1;
