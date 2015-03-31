package SellSmooth::Plugins::Install;

use strict;
use warnings;
use Dancer2;
use Moose;

has conf => ( isa => 'Defined', is => 'ro', );

has email        => ( isa => 'Str', is => 'rw', );
has firstname    => ( isa => 'Str', is => 'rw', );
has lastname     => ( isa => 'Str', is => 'rw', );
has table_prefix => ( isa => 'Str', is => 'rw', );

with 'SellSmooth::Plugin';

debug __PACKAGE__;

get '/install' => sub {

    #Sprachauswahl
    template 'install/index', {}, { layout => 'install' };
};

get '/install/licence' => sub {

    #Lizenzvereinbarung
    template 'install/licence', {}, { layout => 'install' };
};

get '/install/system' => sub {

    #Systemkompatibilität
    template 'install/system', {}, { layout => 'install' };
};

get '/install/db' => sub {

    #Datenbankkompatibilität
    template 'install/db', {}, { layout => 'install' };
};

get '/install/shop' => sub {

    #Shopeinstellungen
    #Thema auswählen (Ticketing, Hospitality, )
    #Plugins installieren
    template 'install/shop', {}, { layout => 'install' };
};

get '/install/system_conf' => sub {

    #Systemkonfiguration
    template 'install/system_conf', {}, { layout => 'install' };
};

get '/install/install' => sub {

    #Installation des Shops
    template 'install/install', {}, { layout => 'install' };
};

get '/install/client' => sub {

    #Clienteinstellungen
    template 'install/client', {}, { layout => 'install' };
};

get '/install/finalize' => sub {
    template 'install/finalize', {}, { layout => 'install' };
};

#while (1) {
#    unless ( $self->email() ) {
#        print "Email: ";
#        my $tmp = <>;
#        chomp($tmp);
#        if ( !Email::Valid->address($tmp) ) {
#            print "No valid email!\n";
#            next;
#        }
#        $self->email($tmp);
#    }
#    unless ( $self->firstname() ) {
#        print "Firstname: ";
#        my $tmp = <>;
#        chomp($tmp);
#        $self->firstname($tmp);
#    }
#    unless ( $self->lastname() ) {
#        print "Lastname: ";
#        my $tmp = <>;
#        chomp($tmp);
#        $self->lastname($tmp);
#    }
#    unless ( $self->prefix() ) {
#        print "Table prefix: ";
#        my $tmp = <>;
#        chomp($tmp);
#        $self->prefix($tmp);
#    }
#    last;
#}
#
#print 'Email:        ' . $self->email() . $/;
#print 'Firstname:    ' . $self->firstname() . $/;
#print 'Lastname:     ' . $self->lastname() . $/;
#print 'Table prefix: ' . $self->prefix() . $/;

no Moose;

1;

__END__

