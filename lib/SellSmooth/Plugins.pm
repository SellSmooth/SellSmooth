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

has plugins => ( default => sub { {} } );
has enabled => ( default => sub { [] } );

has plugin_files => ( isa => 'ArrayRef', is => 'rw', );
has plugin_name  => ( isa => 'Str',      is => 'rw', );

has plugin_dir => (
    isa => 'Str',

    default => sub { File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d' ) }
);

has plugin_class => (
    isa     => LoadableClass,
    lazy    => 1,
    is      => 'rw',
    default => method {
        'SellSmooth::Plugins::' . $self->plugin_name()
    }
);

has plugin_conf => ( is => 'rw', );

has plugin => (
    does => 'SellSmooth::Plugin',
    lazy => 1,
    default =>
      method { $self->plugin_class()->new( conf => $self->plugin_conf() ); }
);

=head1 SUBROUTINES/METHODS

=head2 BUILD

Run to check driver version with installed db driver.

Creates changelog table if it's not existing.

=cut

sub BUILD {
    my $self = shift;
    my @files = glob( File::Spec->catfile( $self->plugin_dir(), '*.yml' ) );
    $self->plugin_files( \@files );
    foreach ( @{ $self->plugin_files() } ) {
        my $conf = LoadFile($_);
        next unless ( $conf->{enabled} );

        $self->plugin_conf($conf);
        $self->plugin_name( $conf->{name} );
        my $class = 'SellSmooth::Plugins::' . $conf->{name};

        $self->plugins()->{ $conf->{name} } = $self->plugin();
        push( @{ $self->enabled() }, $class );
    }
}

no Moose;

1;

__END__

