#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;

use lib "$FindBin::Bin/../lib";
use SellSmooth;

#my $lib = "$FindBin::Bin/../lib";
#
#my $dbh =
#  DBI->connect( "dbi:Pg:dbname=smooth;host=127.0.0.1", "smooth", "smooth" );
#my $obj = DBIx::Schema::Changelog->new( dbh => $dbh, db_driver => 'Pg' );
#$obj->read( $FindBin::Bin . '/../resources/changelog' );
#$dbh->disconnect();
#
#SellSmooth::Core::Utils->createSchema( "SellSmooth::Base::Db::Pg", $lib,
#    "dbi:Pg:dbname=smooth;host=127.0.0.1",
#    "smooth", "smooth", 1 );

SellSmooth->dance;
