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

has plugins => ( default => sub { {} } );

has enabled => (
    lazy    => 1,
    default => sub {
        my $self    = shift;
        my $enabled = [];
        foreach ( @{ $self->plugin_files() } ) {
            my $conf = LoadFile($_);
            next unless ( $conf->{enabled} );
            my $class = 'SellSmooth::Plugins::' . $conf->{name};
            $self->plugin_name( $conf->{name} );
            $self->plugins()->{ $conf->{name} } =
              $self->plugin_class()->new( conf => $conf );
            push( @{$enabled}, $class );
        }
        return $enabled;
    }

);

has plugin_dir => (
    isa     => 'Str',
    lazy    => 1,
    default => sub { File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d' ) }
);

has plugin_name => (
    isa => 'Str',
    is  => 'rw',
);

has plugin_class => (
    isa     => LoadableClass,
    lazy    => 1,
    is      => 'rw',
    default => sub {
        return 'SellSmooth::Plugins::' . shift->plugin_name();
    }
);

has plugin_files => (
    isa     => 'ArrayRef',
    lazy    => 1,
    default => sub {
        my $self = shift;
        my @files = glob( File::Spec->catfile( $self->plugin_dir(), '*.yml' ) );
        return \@files;
    }
);

=head1 SUBROUTINES/METHODS

=cut

no Moose;

1;

__END__

