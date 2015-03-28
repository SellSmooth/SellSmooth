package SellSmooth;

use strict;
use warnings;
use Data::Dumper;
use Module::Load;
use Dancer2;

use SellSmooth::Plugins;

our $VERSION = '0.1.0';

my $plugins = SellSmooth::Plugins->new();
load $_ foreach @{ $plugins->enabled() };

1;
