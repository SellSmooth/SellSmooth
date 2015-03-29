#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use DBI;
use DBIx::Schema::Changelog;

use lib "$FindBin::Bin/../lib";
use SellSmooth;
use SellSmooth::Base::Install;

my $lib = "$FindBin::Bin/../lib";
my $db  = "dbi:Pg:dbname=smooth;host=127.0.0.1";
my $dbh = DBI->connect( $db, "smooth", "smooth" );
my $obj = DBIx::Schema::Changelog->new( dbh => $dbh, db_driver => 'Pg' );
$obj->read( $FindBin::Bin . '/../resources/changelog' );
$dbh->disconnect();

SellSmooth::Base::Install->createSchema( "SellSmooth::Base::Db::Pg",
    $lib, $db, "smooth", "smooth" );

SellSmooth->dance;
