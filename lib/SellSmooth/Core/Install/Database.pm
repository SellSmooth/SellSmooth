package SellSmooth::Core::Install::Database;

use DBIx::Class::Schema::Loader qw/ make_schema_at /;

###############################################################################
sub createSchema {
        my ( $self, $namespace, $path, $driver, $user, $pass, $debug) = @_;
        make_schema_at(
                $namespace,
                {
                        debug          => $debug,
                        dump_directory => $path,
                },
                [ $driver, $user, $pass ]
        );
}

1;
