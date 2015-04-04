package SellSmooth::Core;

use strict;
use warnings;
use Data::Dumper;
use Dancer2;

sub check_install {
    my ( $self, $plugins ) = @_;
    return 1 unless $plugins->plugins()->{Install};
    return 0;
}

1;
