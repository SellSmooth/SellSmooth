package SellSmooth::Core::Password;
use Digest::MD5 'md5_hex';
use Crypt::SaltedHash;
use Crypt::GeneratePassword qw(word);
###############################################################################
sub generate {
    my ($self) = @_;
    return $self->crypt( word( 8, 16 ) );
}
###############################################################################
sub verify {
    my ( $self, $user, $password ) = @_;
    $password = md5_hex($password);
    my $crypt2 = Crypt::SaltedHash->new( algorithm => 'SHA-512' );
    return 0 if ( !$crypt2->validate( $user->{pass}, $password ) );
    return 1;
}
###############################################################################
sub getSHash {
    my ( $self, $password ) = @_;
    my $new = Crypt::SaltedHash->new( algorithm => 'SHA-512' );
    $new->add( md5_hex($password) );
    return $new->generate();
}
###############################################################################
sub crypt {
    my ( $self, $word ) = @_;
    my $crypt = Crypt::SaltedHash->new( algorithm => 'SHA-512' );
    $crypt->add( md5_hex($word) );
    return {
        word => $word,
        sh   => $crypt->generate(),
        salt => $crypt->salt_hex()
    };
}
###############################################################################
1;
