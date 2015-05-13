package SellSmooth::Plugins::Install;

use strict;
use warnings;
use Dancer2;
use Data::Dumper;
use Moose;
use SellSmooth::Plugins::Install::Params;
use Module::Install::Live;
use YAML::XS qw/LoadFile/;
use Data::YAML::Writer;
use SellSmooth::Base::Client;
use SellSmooth::Base::User;
use SellSmooth::Base::Template;
use SellSmooth::Base::Install;

with 'SellSmooth::Plugin';

my $install_file = File::Spec->catfile( $FindBin::Bin, '..', 'plugins.d', 'install.yml' );
my $params = undef;

open my $rfh, '<', $install_file or die "$install_file $!";
my $plugin_hash = LoadFile($install_file);
close $rfh;

debug __PACKAGE__;

get '/install' => sub {
    $params = SellSmooth::Plugins::Install::Params->new();
    return redirect '/install/shop' if ( $plugin_hash->{db_finished} );

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

    unless ( $plugin_hash->{db_finished} ) {
        my $lib = File::Spec->catfile( $FindBin::Bin, '..', 'lib' );
        my $db  = "dbi:$p{dbEngine}:dbname=$p{dbName};host=$p{dbServer}";
        my $dbh = DBI->connect(
            $db,
            $p{dbLogin},
            $p{dbPassword},
            {
                pg_utf8_strings => 1,
            }
        );
        my $obj = DBIx::Schema::Changelog->new(
            dbh       => $dbh,
            db_driver => $p{dbEngine}
        );
        $obj->table_action()->prefix( ( defined $p{db_prefix} ) ? $p{db_prefix} : '' );
        $obj->read( File::Spec->catfile( $FindBin::Bin, '..', 'resources', 'changelog' ) );

        $dbh->disconnect();

        SellSmooth::Base::Install->createSchema( "SellSmooth::Base::Db::$p{dbEngine}",
            $lib, $db, $p{dbLogin}, $p{dbPassword} );

        $plugin_hash->{db_finished} = 1;
        open $rfh, "> $install_file" or die $!;
        my $yw = Data::YAML::Writer->new;
        $yw->write( $plugin_hash, $rfh );

        close $rfh;
    }

    #Shopeinstellungen
    #Grundsystem auswählen (Simple, Admin, Standard, Full)
    #Plugins installieren
    template 'install/shop', {}, { layout => 'install' };
};

get '/install/install' => sub {
    return redirect '/install' unless $params;
    my %p = params;
    $params->shop_settings( \%p );

    #Module::Install::Live->install( $p{'plugins[]'} );

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

    my $clientHdl = SellSmooth::Base::Client->new();
    $p{client} = $clientHdl->create( \%p );

    my $userHdl = SellSmooth::Base::User->new();
    $p{user} = $userHdl->create( \%p );

    SellSmooth::Base::Template->new( client => $p{client} )->create();

    $plugin_hash->{enabled} = 0;

    open $rfh, "> $install_file" or die $!;
    my $yw = Data::YAML::Writer->new;
    $yw->write( $plugin_hash, $rfh );
    close $rfh;

    template 'install/finalize', {}, { layout => 'install' };
};

no Moose;

1;

__END__

