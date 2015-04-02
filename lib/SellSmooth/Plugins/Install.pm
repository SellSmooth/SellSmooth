package SellSmooth::Plugins::Install;

use strict;
use warnings;
use Dancer2;
use Data::Dumper;
use Moose;
use SellSmooth::Plugins::Install::Params;
use Module::Install::Live;

with 'SellSmooth::Plugin';

my $params = undef;

debug __PACKAGE__;

get '/install' => sub {
    $params = SellSmooth::Plugins::Install::Params->new();

    #Sprachauswahl
    template 'install/index', {}, { layout => 'install' };
};

get '/install/licence' => sub {
    return redirect '/install' unless $params;
    $params->install_language( params->{language} );

    #Lizenzvereinbarung
    template 'install/licence', {}, { layout => 'install' };
};

get '/install/system' => sub {
    return redirect '/install' unless $params;
    $params->license( ( params->{licence_agrement} ) ? 1 : 0 );

    #Systemkompatibilität
    template 'install/system', {}, { layout => 'install' };
};

get '/install/db' => sub {
    return redirect '/install' unless $params;
    $params->system_check(1);

    #Datenbankkompatibilität
    template 'install/db', {}, { layout => 'install' };
};

get '/install/shop' => sub {
    return redirect '/install' unless $params;
    my %p = params;
    $params->db_settings( \%p );

    my $lib = "$FindBin::Bin/../lib";
    my $db  = "dbi:$p{dbEngine}:dbname=$p{dbName};host=$p{dbServer}";
    my $dbh = DBI->connect( $db, $p{dbLogin}, $p{dbPassword} );
    my $obj =
      DBIx::Schema::Changelog->new( dbh => $dbh, db_driver => $p{dbEngine} );
    $obj->table_action()
      ->prefix( ( defined $p{db_prefix} ) ? $p{db_prefix} : '' );
    $obj->read( $FindBin::Bin . '/../resources/changelog' );
    $dbh->disconnect();

    #Shopeinstellungen
    #Grundsystem auswählen (Simple, Admin, Standard, Full)
    #Plugins installieren
    template 'install/shop', {}, { layout => 'install' };
};

get '/install/install' => sub {
    return redirect '/install' unless $params;
    my %p = params;
    $params->shop_settings( \%p );
    debug Dumper( \%p );

    Module::Install::Live->install( $p{'plugins[]'} );

    #Installation des Shops
    redirect '/install/client';
};

get '/install/client' => sub {
    return redirect '/install' unless $params;

    #Clienteinstellungen
    #Thema auswählen (Ticketing, Hospitality, Retail)
    template 'install/client', {}, { layout => 'install' };
};

get '/install/finalize' => sub {
    return redirect '/install' unless $params;
    my %p = params;
    $params->client_settings( \%p );
    debug Dumper($params);

    #Client erstellen
    # template daten für den client speichern
    template 'install/finalize', {}, { layout => 'install' };
};

no Moose;

1;

__END__

