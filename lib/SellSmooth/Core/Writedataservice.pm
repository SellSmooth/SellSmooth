use utf8;

package SellSmooth::Core::Writedataservice;
use Data::Dumper;
use Dancer2;
use Dancer2::Plugin::DBIC qw(schema resultset rset);
use TryCatch;
###############################################################################
sub create {
	my ( $schema, $options ) = @_;
	try {
		print Dumper($schema, $options);
		my $res = schema->resultset($schema)->create($options);
		return undef unless ($res);
		return undef unless ( $res->{_column_data} );
		my $ret = SellSmooth::Core::Loaddataservice::findById( $schema, $res->{_column_data}->{id} );
		return SellSmooth::Core::Loaddataservice::find( $schema, $options ) unless ($ret);
		return $ret;
	}
	catch($err) {
		warn $err;
		  return undef;
	};
}
###############################################################################
sub delete {
	my ( $schema, $options ) = @_;
	my $res = schema->resultset($schema)->find($options);
	return ( defined $res && defined $res->{_column_data} ) ? $res->delete() : 0;
}
###############################################################################
sub deleteAll {
	my ( $schema, $options ) = @_;
	return schema->resultset($schema)->search($options)->delete_all();
}
###############################################################################
sub find_or_create {
	my ( $schema, $options ) = @_;
	try {
		my $res = schema->resultset($schema)->find_or_create($options);
		return undef unless ($res);
		return undef unless ( $res->{_column_data} );
		my $ret = SellSmooth::Core::Loaddataservice::findById( $schema, $res->{_column_data}->{id} );
		return SellSmooth::Core::Loaddataservice::find( $schema, $options ) unless ($ret);
		return $ret;
	}
	catch($err) {
		warn $err;
		  return undef;
	};
}
###############################################################################
sub removeById {
	my ( $schema, $object ) = @_;
	return undef if ( !defined $object || !defined $object->{id} );
	my $result = schema->resultset($schema)->find( { id => $object->{id} } );
	return $result->delete();
}
###############################################################################
sub toggle {
	my ( $schema, $find, $param ) = @_;
	try {
		my $res = schema->resultset($schema)->find_or_create( $find );
		return 0 if ( !defined $res || !defined $res->{_column_data} );
		my $old = $res->{_column_data}->{$param};
		my $new = ( $old > 0 ) ? 0 : 1;
		debug qq~$param in schema $schema was $old switched to $new~;
		return $res->update( { $param => $new } );
	}
	catch($err) {
		warn $err;
		  return undef;
	};
}
###############################################################################
sub update_or_create {
	my ( $schema, $update, $options ) = @_;
	try {
		my $res = schema->resultset($schema)->update_or_create( $update, $options );
		return undef unless ($res);
		return undef unless ( $res->{_column_data} );
		my $ret = SellSmooth::Core::Loaddataservice::findById( $schema, $res->{_column_data}->{id} );
		return SellSmooth::Core::Loaddataservice::find( $schema, $update ) unless ($ret);
		return $ret;
	}
	catch($err) {
		warn $err;
		  return undef;
	};
}
###############################################################################
sub update {
	my ( $schema, $object, $options ) = @_;
	try {
		my $res = schema->resultset($schema)->find($object);
		$res->update($options);
		return $res->{_column_data};
	}
	catch($err) {
		warn $err;
		  return undef;
	};
}
###############################################################################
sub update_all {
	my ( $schema, $object, $options ) = @_;
	try {
		my $res = schema->resultset($schema)->search($object);
		$res->update_all($options);
		my $ret = [];
		foreach ( $res->all() ) { push( @$ret, $_->{_column_data} ); }
		return $ret;
	}
	catch($err) {
		warn $err;
		  return undef;
	};
}
1;
