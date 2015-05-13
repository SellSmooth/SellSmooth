use strict;
use warnings;
use ExtUtils::MakeMaker;

# Normalize version strings like 6.30_02 to 6.3002,
# so that we can do numerical comparisons on it.
my $eumm_version = $ExtUtils::MakeMaker::VERSION;
$eumm_version =~ s/_//;

WriteMakefile(
    NAME         => 'SS',
    AUTHOR       => q{YOUR NAME <youremail@example.com>},
    VERSION_FROM => 'lib/SS.pm',
    ABSTRACT     => 'YOUR APPLICATION ABSTRACT',
    (
        $eumm_version >= 6.3001
        ? ( 'LICENSE' => 'perl' )
        : ()
    ),
    PL_FILES  => {},
    PREREQ_PM => {
        'Test::More'              => 0,
        'YAML'                    => 0,
        'Dancer2'                 => 0.158000,
        'DBIx::Schema::Changelog' => 0.7.2,
        'Data::YAML::Writer'      => 0.0.7,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'SS-*' },
);
