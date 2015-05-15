package Dancer2::Plugin::Localization;

use strict;
use warnings;
use Dancer2;
use Dancer2::Plugin;
use Data::Dumper;
use HTTP::BrowserDetect;
use FindBin;
use JSON::Parse 'json_file_to_perl';

my ($langs) = _getAll();
#
our $VERSION = '0.001';
#
register language_country => sub {
    my $dsl   = shift;
    my $loc   = plugin_setting();
    my $agent = $dsl->request->env->{HTTP_ACCEPT_LANGUAGE};
    return ( defined $loc && defined $loc->{default} ) ? $loc->{default} : 'en_us' if ( !defined $agent );
    my $browser = HTTP::BrowserDetect->new($agent);
    my $lang    = ( defined $browser->language() ) ? lc $browser->language() : 'en';
    my $coun    = ( defined $browser->country() ) ? lc $browser->country() : 'us';
    print Dumper( $browser, $lang, $coun );
    my %loc_maped = map { $_ => 1 } @{ $loc->{supported} };
    return $lang . '_' . $coun if ( exists $loc_maped{ $lang . '_' . $coun } );
    return ( exists $loc->{$lang} ) ? $loc->{$lang} : $loc->{default};
};

register supported => sub {
    my $dsl = shift;
    my $loc = plugin_setting();
    return $loc->{supported};
};

register default => sub {
    my $dsl = shift;
    my $loc = plugin_setting();
    return $loc->{default};
};

register tags => sub {
    my $dsl  = shift;
    my $lang = shift;
    return $langs->{$lang};
};

register_plugin for_versions => [2];

###############################################################################
sub _getAll {
    my ($schema) = @_;
    my $ret      = {};
    my $loc      = plugin_setting();
    my $path = File::Spec->catfile( $FindBin::Bin, '..', $loc->{path} );
    foreach my $l ( @{ $loc->{supported} } ) {
        $ret->{$l} = json_file_to_perl( File::Spec->catfile( $path, $l . '.json' ) );
    }
    return $ret;
}
###############################################################################

1;
