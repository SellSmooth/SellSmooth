package SellSmooth::Core::Pager;
use strict;
use warnings;
use Math::Round qw(nhimult);
###############################################################################
sub calcPager {
	my ( $total, $rows ) = @_;
	my $ret = nhimult( 1, ( $total / $rows ) );
	return '1' if ( $ret <= 0 );
	return $ret;
}
1;
