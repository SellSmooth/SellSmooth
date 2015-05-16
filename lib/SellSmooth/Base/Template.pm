package SellSmooth::Base::Template;

=head1 NAME

SellSmooth::Base::Template - Template class for new master clients.

=head1 VERSION

Version 0.1.0

=cut

our $VERSION = '0.1.0';

use utf8;
use strict;
use warnings;
use Data::Dumper;
use Dancer2;
use Moose;
use MooseX::HasDefaults::RO;
use Method::Signatures::Simple;

use SellSmooth::Base::Assortment;
use SellSmooth::Base::Currency;
use SellSmooth::Base::Language;
use SellSmooth::Base::Product;
use SellSmooth::Base::PriceList;
use SellSmooth::Base::SalesTax;
use SellSmooth::Base::Sector;
use SellSmooth::Base::ProductPrice;
use SellSmooth::Base::OrganizationalUnit;
use SellSmooth::Base::OrgAssortment;
use SellSmooth::Base::SectorTaxItem;
use SellSmooth::Base::SalesTaxRate;
use SellSmooth::Base::EconomicZone;
use SellSmooth::Base::CommodityGroup;

has client => ( isa => 'Defined' );

has assortment => (
    lazy    => 1,
    default => sub {
        [ { name => 'Standard', number => 1, client => shift->client()->{id}, } ];
    }
);

has commodity_group => (
    lazy    => 1,
    default => method {
        [
            { name => 'Standard', number => 1, has_children => 0, client => $self->client()->{id}, },
            { name => 'Drinks',   number => 2, has_children => 0, client => $self->client()->{id}, },
            { name => 'Foods',    number => 3, has_children => 0, client => $self->client()->{id}, },
        ];
    }
);

has economic_zone => (
    lazy    => 1,
    default => sub {
        { name => 'Germany', number => 1, client => shift->client()->{id}, };
    }
);

has org => (
    lazy    => 1,
    default => sub {
        [
            {
                name          => 'Standard',
                number        => 1,
                economic_zone => 1,
                has_children  => 0,
                price_list    => 1,
                client        => shift->client()->{id},
            }
        ];
    }
);

has price_list => (
    lazy    => 1,
    default => method {
        [
            { name => 'Standard', number => 1, currency => 'EUR', net_prices => 0, client => $self->client()->{id}, },
            { name => 'List 2',   number => 2, currency => 'EUR', net_prices => 0, client => $self->client()->{id}, },
            { name => 'List 3',   number => 3, currency => 'EUR', net_prices => 0, client => $self->client()->{id}, }
        ];
    }
);

has product => (
    lazy    => 1,
    default => method {
        [
            {
                name            => 'Sparkling Water',
                number          => 1,
                sector          => 2,
                assortment      => 1,
                commodity_group => 2,
                client          => $self->client()->{id},
            },
            {
                name            => 'Curry Sausages',
                number          => 2,
                sector          => 2,
                assortment      => 1,
                commodity_group => 3,
                client          => $self->client()->{id},
            },
            {
                name            => 'Cola',
                number          => 3,
                sector          => 2,
                assortment      => 1,
                commodity_group => 2,
                client          => $self->client()->{id},
            },
            {
                name            => 'Coffe',
                number          => 4,
                sector          => 2,
                assortment      => 1,
                commodity_group => 2,
                client          => $self->client()->{id},
            },
            {
                name            => 'Shoes',
                number          => 5,
                sector          => 1,
                assortment      => 1,
                commodity_group => 1,
                client          => $self->client()->{id},
            }
        ];
    }
);

has sales_tax => (
    lazy    => 1,
    default => method {
        [
            { name => 'Standard', number => 1, economic_zone => 1, included => 1, client => $self->client()->{id}, },
            { name => 'Reduced',  number => 2, economic_zone => 1, included => 1, client => $self->client()->{id}, },
            { name => 'Tax Free', number => 3, economic_zone => 1, included => 1, client => $self->client()->{id}, },
        ];
    }
);

has sales_tax_rates => (
    lazy    => 1,
    default => sub {
        [
            { valid_from => '2014-04-06', sales_tax => 1, percentage => 19, },
            { valid_from => '2014-04-06', sales_tax => 2, percentage => 7, },
            { valid_from => '2014-04-06', sales_tax => 3, percentage => 0, },
        ];
    }
);

has sector => (
    lazy    => 1,
    default => method {
        [
            { name => 'Standard', number => 1, client => $self->client()->{id}, },
            { name => 'Reduced',  number => 2, client => $self->client()->{id}, },
            { name => 'Tax Free', number => 3, client => $self->client()->{id}, },
        ];
    }
);

has sector_tax_items => (
    lazy    => 1,
    default => sub {
        [
            { sector => 1, tax_index => 1, sales_tax => 1, },
            { sector => 3, tax_index => 1, sales_tax => 3, },
            { sector => 2, tax_index => 1, sales_tax => 2, },
        ];
    }
);

has product_prices => (
    lazy    => 1,
    default => sub {
        [
            { product => 1, price_list => 1, value => 2.95, },
            { product => 1, price_list => 2, value => 4.95, },
            { product => 1, price_list => 3, value => 1.95, },
            { product => 2, price_list => 1, value => 1.95, },
            { product => 2, price_list => 2, value => 0.95, },
            { product => 2, price_list => 3, value => 1.45, },
            { product => 1, price_list => 1, value => 2.55, valid_from => '2014-04-06', },
            { product => 1, price_list => 2, value => 4.55, valid_from => '2014-04-06', },
            { product => 1, price_list => 3, value => 1.55, valid_from => '2014-04-06', },
            { product => 2, price_list => 1, value => 1.55, valid_from => '2014-04-06', },
            { product => 2, price_list => 2, value => 0.55, valid_from => '2014-04-06', },
            { product => 2, price_list => 3, value => 1.55, valid_from => '2014-04-06', },
        ];
    }
);

has org_assortments => (
    lazy    => 1,
    default => sub {
        [ { org => 1, assortment => 1, valid_from => '2014-04-06', }, ];
    }
);

has languages => (
    lazy    => 1,
    default => method {
        [
            { iso_code => 'eng', number => 1, name => 'English', client => $self->client()->{id}, },
            { number => 2, name => 'German', client => $self->client()->{id}, iso_code => 'ger', },
        ];
    }
);

has handlers => (
    lazy    => 1,
    default => method {
        my $cl = $self->client();
        print Dumper($cl);
        return {
            assortment      => SellSmooth::Base::Assortment->new( client     => $cl, db_object => 'Assortment' ),
            commodity_group => SellSmooth::Base::CommodityGroup->new( client => $cl, db_object => 'CommodityGroup' ),
            currency        => SellSmooth::Base::Currency->new( client       => $cl, db_object => 'Currency' ),
            economic_zone   => SellSmooth::Base::EconomicZone->new( client   => $cl, db_object => 'EconomicZone' ),
            language        => SellSmooth::Base::Language->new( client       => $cl, db_object => 'Language' ),
            org_unit => SellSmooth::Base::OrganizationalUnit->new( client => $cl, db_object => 'OrganizationalUnit' ),
            org_assortment => SellSmooth::Base::OrgAssortment->new( client => $cl, db_object => 'OrgAssortment' ),
            product_price  => SellSmooth::Base::ProductPrice->new( client  => $cl, db_object => 'ProductPrice' ),
            product        => SellSmooth::Base::Product->new( client       => $cl, db_object => 'Product' ),
            price_list     => SellSmooth::Base::PriceList->new( client     => $cl, db_object => 'PriceList' ),
            sales_tax      => SellSmooth::Base::SalesTax->new( client      => $cl, db_object => 'SalesTax' ),
            sector         => SellSmooth::Base::Sector->new( client        => $cl, db_object => 'Sector' ),
            sales_tax_item => SellSmooth::Base::SectorTaxItem->new( client => $cl, db_object => 'SectorTaxItem' ),
            sales_tax_rate => SellSmooth::Base::SalesTaxRate->new( client  => $cl, db_object => 'SalesTaxRate' ),
        };
    }
);

sub create {
    my ($self) = @_;

    my ( $ass, $cg, $cur, $pl, $orgs, $st, $se, $pr, $lang ) = {};
    my $ez = $self->handlers->{economic_zone}->create( $self->economic_zone() );
    $ass->{ $_->{number} } = $self->handlers->{assortment}->create($_)      foreach ( @{ $self->assortment() } );
    $cg->{ $_->{number} }  = $self->handlers->{commodity_group}->create($_) foreach ( @{ $self->commodity_group() } );
    $se->{ $_->{number} }  = $self->handlers->{sector}->create($_)          foreach ( @{ $self->sector() } );

    $self->handlers->{language}->create($_) foreach ( @{ $self->languages() } );
    $cur->{ $_->{currency_key} } = $_ foreach ( @{ $self->handlers->{currency}->list() } );

    foreach ( @{ $self->price_list() } ) {
        $_->{currency} = $cur->{ $_->{currency} }->{id};
        $pl->{ $_->{number} } = $self->handlers->{price_list}->create($_);
    }
    foreach ( @{ $self->org() } ) {
        $_->{economic_zone}     = $ez->{id};
        $_->{price_list}        = $pl->{ $_->{price_list} }->{id};
        $orgs->{ $_->{number} } = $self->handlers->{org_unit}->create($_);
    }

    foreach ( @{ $self->sales_tax() } ) {
        $_->{economic_zone} = $ez->{id};
        $st->{ $_->{number} } = $self->handlers->{sales_tax}->create($_);
    }

    foreach ( @{ $self->sales_tax_rates() } ) {
        $_->{sales_tax} = $st->{ $_->{sales_tax} }->{id};
        $self->handlers->{sales_tax_rate}->create($_);
    }

    foreach ( @{ $self->sector_tax_items() } ) {
        $_->{sales_tax} = $st->{ $_->{sales_tax} }->{id};
        $_->{sector}    = $se->{ $_->{sector} }->{id};
        $self->handlers->{sales_tax_item}->create($_);
    }

    foreach ( @{ $self->product() } ) {
        $_->{assortment}      = $ass->{ $_->{assortment} }->{id};
        $_->{sector}          = $se->{ $_->{sector} }->{id};
        $_->{commodity_group} = $cg->{ $_->{commodity_group} }->{id};
        $pr->{ $_->{number} } = $self->handlers->{product}->create($_);
    }

    foreach ( @{ $self->product_prices() } ) {
        $_->{product}    = $pr->{ $_->{product} }->{id};
        $_->{price_list} = $pl->{ $_->{price_list} }->{id};
        $self->handlers->{product_price}->create($_);
    }

    foreach ( @{ $self->org_assortments() } ) {
        $_->{org}        = $orgs->{ $_->{org} }->{id};
        $_->{assortment} = $ass->{ $_->{assortment} }->{id};
        $self->handlers->{org_assortment}->create($_);
    }

}

no Moose;
__PACKAGE__->meta->make_immutable;

1;    # End of SellSmooth::Base::Template

__END__

=head1 AUTHOR

Mario Zieschang, C<< <mario.zieschang at combase.de> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2015 Mario Zieschang.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, trade name, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANT ABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

