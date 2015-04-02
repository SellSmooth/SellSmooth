package SellSmooth::Plugins::Install::Params;

use strict;
use warnings;
use Dancer2;
use Data::Dumper;
use MooseX::Types::Moose qw(HashRef Str Defined Int);
use Moose;

has install_language => ( isa => 'Str',     is => 'rw' );
has license          => ( isa => 'Int',     is => 'rw' );
has system_check     => ( isa => 'Int',     is => 'rw' );
has db_settings      => ( isa => 'HashRef', is => 'rw' );
has shop_settings    => ( isa => 'HashRef', is => 'rw' );
has client_settings  => ( isa => 'HashRef', is => 'rw' );

no Moose;

1;

__END__
