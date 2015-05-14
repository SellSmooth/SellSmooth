package SellSmooth::Base::Object;

=head1 NAME

SellSmooth::Base::Object - Abstract object class for db objects.

=head1 VERSION

Version 0.1.0

=cut

our $VERSION = '0.1.0';

use strict;
use warnings FATAL => 'all';
use Moose::Role;
use SellSmooth::Core::Writedataservice;
use SellSmooth::Core::Loaddataservice;

has client    => ( isa => 'Defined', is => 'ro' );
has db_object => ( isa => 'Defined', is => 'ro', );

=head1 SUBROUTINES/METHODS

=head2 create

Required sub to run create for specific action type.

=cut

sub create {
    my ( $self, $params ) = @_;
    return SellSmooth::Core::Writedataservice::create( $self->db_object(), $params );
}

=head2 update

Required sub to run update for specific action type.

=cut

sub update {
    my ( $self, $object, $options ) = @_;
    return SellSmooth::Core::Writedataservice::update( $self->db_object(), $object, $options );

}

=head2 delete

Set current object only to inactive.

=cut

sub delete {
    my ( $self, $object ) = @_;
    return $self->update( $object, { active => 0 } );
}

=head2 remove

Remove the current object from db.
Can not be undone!!!

=cut

sub remove {
    my ( $self, $params ) = @_;
    return SellSmooth::Core::Writedataservice::removeById( $self->db_object(), $params );
}

=item find_by_number

=cut

sub find_by_number {
    my ( $self, $number ) = @_;
    return SellSmooth::Core::Loaddataservice::findByNumber( $self->db_object(), $number );
}

=item find_by_id

=cut

sub find_by_id {
    my ( $self, $id ) = @_;
    return SellSmooth::Core::Loaddataservice::findById( $self->db_object(), $id );
}

=item find_by_id

=cut

sub list {
    my ( $self, $params, $options ) = @_;
    return SellSmooth::Core::Loaddataservice::list( $self->db_object(), $params, $options );
}

1;    # End of SellSmooth::Plugin

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

