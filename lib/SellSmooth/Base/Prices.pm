package SellSmooth::Base::Prices;

=head1 NAME

SellSmooth::Base::Prices - Abstract plugin class.

=head1 VERSION

Version 0.1.0

=cut

our $VERSION = '0.1.0';

use strict;
use warnings;
use Dancer2;
use Moose;
use Data::Dumper;
use SellSmooth::Core::Writedataservice;
use SellSmooth::Core::Loaddataservice;

with 'SellSmooth::Base::Object';

=head1 SUBROUTINES/METHODS

=over 4

=item findByNumber

=cut

sub findByProduct {
    my ( $self, $product ) = @_;

    my $db_prices = SellSmooth::Core::Loaddataservice::list(
        'ProductPrice',
        { product  => $product->{id} },
        { order_by => { '-asc' => 'valid_from' } }
    );

    my $tmp = {};
    foreach (@$db_prices) {
        unless ( $tmp->{ $_->{valid_from} } ) {
            $tmp->{ $_->{valid_from} } = {
                valid_from => $_->{valid_from},
                values     => []
            };
        }
        push( @{ $tmp->{ $_->{valid_from} }->{values} }, $_ );
    }
    my $ret = [];
    push( @$ret, $tmp->{$_} ) foreach ( sort( keys %$tmp ) );
    return $ret;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;    # End of SellSmooth::Base::Prices

__END__

=head1 AUTHOR

Mario Zieschang, C<< <mario.zieschang at combase.de> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2015 Mario Zieschang.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, trade name, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANT ABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

