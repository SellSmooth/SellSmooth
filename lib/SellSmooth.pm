package SellSmooth;
use Dancer2;

our $VERSION = '0.1.0';

get '/' => sub {
    template 'index';
};

get '/install' => sub {

    template 'install/index';
};

1;
