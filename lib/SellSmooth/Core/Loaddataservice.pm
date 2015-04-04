package SellSmooth::Core::Loaddataservice;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use SellSmooth::Core::Pager;
use Dancer2;
use Dancer2::Plugin::DBIC qw(schema resultset rset);
use TryCatch;
###############################################################################
sub count {
	my ( $schema, $search, $options ) = @_;
	return schema->resultset($schema)->search( $search, $options )->count;
}
###############################################################################
sub find {
	my ( $schema, $options, $path ) = @_;
	return undef if ( !defined $options || !defined $schema );
	try {
		my $res = schema->resultset($schema)->search($options) || die $!;
		foreach ( $res->all() ) { return $_->{_column_data}; }
	}
	catch($err) {
		warn $err;
		  return undef;
	};
	return undef;
}
###############################################################################
sub findById {
	my ( $schema, $id ) = @_;
	return undef if ( !defined $id || !defined $schema );
	return find( $schema, { id => $id, } );
}
###############################################################################
sub findByIdAndActive {
	my ( $schema, $id ) = @_;
	return undef if ( !defined $id || !defined $schema );
	return find( $schema, { active => 1, id => $id, } );
}
###############################################################################
sub findByName {
	my ( $schema, $name ) = @_;
	return undef if ( !defined $name || !defined $schema );
	return list( $schema, { name => $name, } );
}
###############################################################################
sub findByNameAndActive {
	my ( $schema, $name ) = @_;
	return undef if ( !defined $name || !defined $schema );
	return list( $schema, { active => 1, name => $name, } );
}
###############################################################################
sub findByNumber {
	my ( $schema, $number ) = @_;
	try {
		my $res = schema->resultset($schema)->search( { active => 1, number => $number, }, ) || die $!;
		foreach ( $res->all() ) { return $_->{_column_data}; }
	}
	catch($err) {
		warn $err;
		  return undef;
	};
	return undef;
}
###############################################################################
sub findByUser {
	my ( $schema, $user, $options ) = @_;
	my $results = schema->resultset($schema)->search( { active => 1, dbuser => $user->{id}, }, $options );
	my $ret = [];
	foreach ( $results->all() ) { push( @$ret, $_->{_column_data} ); }
	return $ret;
}
###############################################################################
sub findByNumberAndUser {
	my ( $schema, $number, $user ) = @_;
	my @results = schema->resultset($schema)->search(
		{

			#		active => 1,
			number => $number,
			dbuser => $user->{id},
		},
	)->all();
	my @ret = ();
	foreach (@results) {
		$_->{_column_data}->{user} = $user;
		return $_->{_column_data};
	}
	return undef;
}
###############################################################################
sub listActive {
	my ( $schema, $options ) = @_;
	return list( $schema, { active => 1 }, $options );
}
###############################################################################
sub list {
	my ( $schema, $search, $options ) = @_;
	try {
		my $results = schema->resultset($schema)->search( $search, $options );
		my $ret = [];
		foreach ( $results->all() ) { push( @$ret, $_->{_column_data} ); }
		return $ret unless ($options);
		return $ret unless ( $options->{page} );

		#
		my $pager = $results->pager();
		return {
			content       => $ret,
			total_entries => $pager->total_entries(),
			first_page    => 1,
			curr_page     => $options->{page},
			last_page     => SellSmooth::Core::Pager::calcPager( $pager->total_entries(), $options->{rows} || 10 ),
		};
	}
	catch($err) {
		warn $err;
		  return undef;
	};

}
1;
