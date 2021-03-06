package SellSmooth::Core::Command::Create;

=head1 NAME

SellSmooth::Core::Command::Create - Command Line module for SellSmooth::Core

=head1 VERSION

Version 0.1.0

=cut

our $VERSION = '0.1.0';

use strict;
use warnings;
use Data::Dumper;
use Email::Valid;
use MooseX::Types::Moose qw(Str Defined);
use Moose;

has conf => ( isa => 'Defined', is => 'ro', );
has name => ( isa => 'Str',     is => 'rw', );

=head2 run

Is called from the changelog-run in bin directory

=cut

sub run {
    my ($self) = @_;
    while (1) {
        unless ( $self->name() ) {
            print "Email: ";
            my $tmp = <>;
            chomp($tmp);
            $self->name($tmp);
        }
        last;
    }

    print 'Shop name: ' . $self->email() . $/;
}

no Moose;

1;

__END__


=head1 SYNOPSIS

    sellsmooth  [commands] [options]

=head1 OPTIONS

=over 4

    Commands:
    -c, --client   : Will create a new client

    Options:
    -u, --user        : User to connect with remote db
    -p, --pass        : Pass for user to connect with remote db
    -e, --email, -@   : Email of author of new file or driver

=back

=head1 SEE ALSO

=over 4

=item L<module::Starter>   The package from which the idea originated.

=back

=head1 AUTHOR

=over 4

Mario Zieschang, C<< <mario.zieschang at combase.de> >>

=back

=head1 LICENSE AND COPYRIGHT

=over 1

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

=back

=cut
