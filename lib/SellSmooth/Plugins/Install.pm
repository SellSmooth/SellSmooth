package SellSmooth::Plugins::Install;

use strict;
use warnings;
use Dancer2;
use Data::Dumper;
use MooseX::Types::Moose qw(HashRef Str Defined Int);
use Moose;

with 'SellSmooth::Plugin';

has conf => ( isa => 'Defined', is => 'ro', );

has install_language => ( isa => 'Str',     is => 'rw', );
has license          => ( isa => 'Int',     is => 'rw', );
has system_check     => ( isa => 'Int',     is => 'rw', );
has db_settings      => ( isa => 'HashRef', is => 'ro', default => sub { {} } );
has shop_settings    => ( isa => 'HashRef', is => 'ro', default => sub { {} } );
has client_settings  => ( isa => 'HashRef', is => 'ro', default => sub { {} } );

debug __PACKAGE__;

get '/install' => sub {

    #Sprachauswahl
    template 'install/index', {}, { layout => 'install' };
};

get '/install/licence' => sub {
    my $self = shift;
    #$self->install_language( params->{language} );
    debug Dumper($self);

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
    #Grundsystem auswählen (Simple, Admin, Standard, Full)
    #Plugins installieren
    template 'install/shop', {}, { layout => 'install' };
};

get '/install/install' => sub {

    #Installation des Shops
    template 'install/install', {}, { layout => 'install' };
};

get '/install/client' => sub {

    #Clienteinstellungen
    #Thema auswählen (Ticketing, Hospitality, Retail)
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

