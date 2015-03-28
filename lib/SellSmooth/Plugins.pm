package SellSmooth::Plugins;

use strict;
use warnings;
use Data::Dumper;
use Dancer2;
use Moose;
use YAML::XS qw/LoadFile/;
use MooseX::HasDefaults::RO;
use MooseX::Types::Moose qw(ArrayRef Str Defined);
use MooseX::Types::LoadableClass qw(LoadableClass);
use Method::Signatures::Simple;

has plugin_dir => (
    isa     => 'Str',
    default => sub { "$FindBin::Bin/../plugins.d" }
);

has plugin_class => (
    isa     => LoadableClass,
    lazy    => 1,
    is      => 'rw',
    default => method {
        'SellSmooth::Plugins::' . $self->plugin_name()
    }
);

has plugin_name => (
    is => 'Str',
    is => 'rw',
);

has plugin_conf => ( is => 'rw', );

has plugin => (
    does => 'SellSmooth::Plugin',
    lazy => 1,
    default =>
      method { $self->plugin_class()->new( conf => $self->plugin_conf() ); }
);

has plugins => ( default => sub { [] } );

=head1 SUBROUTINES/METHODS

=head2 BUILD

Run to check driver version with installed db driver.

Creates changelog table if it's not existing.

=cut

sub BUILD {
    my $self = shift;

    my @files = glob( $self->plugin_dir() . '/*.yml' );

    foreach (@files) {
        $self->plugin_conf( LoadFile($_) );
        $self->plugin_name( $self->plugin_conf()->{name} );
        push(
            @{ $self->plugins() },
            'SellSmooth::Plugins::' . $self->plugin_name()
        );
    }

}

1;
