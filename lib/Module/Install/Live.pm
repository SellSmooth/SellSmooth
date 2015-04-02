package Module::Install::Live;

use App::cpanminus;

sub install {
    my ( $self, $package ) = @_;
    my @commands = ( "cpan", '-i' );
    push( @commands, @$package );
    system(@commands) == 0
      or die "system @args failed: $?";
}

1;

__END__
