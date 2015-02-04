#!/usr/bin/perl -w 

use FindBin;
use lib "$FindBin::Bin/../../../../../perl_lib";

# generate symplectic_xwalks_toolkit_config_eprints.xml

use EPrints;
use XML::Simple;
use strict;

my $repoid = $ARGV[0];
my $session = new EPrints::Session( 1 , $repoid );
if( !defined $session )
{
	print STDERR "Failed to load repository: $repoid\n";
	exit 1;
}

my @FIELDS;

my $dataset = $session->dataset( "eprint" );
foreach my $field ( $dataset->fields )
{
	next if defined $field->{parent}; # skip subfields

	my $F = {
		name => $field->name,
		type => $field->type,
	};
	$F->{multiple} = "true" if $field->property( "multiple" );

	if( $field->type eq "compound" )
	{
		foreach my $subfield ( @{ $field->property( "fields" ) } )
		{
			push @{ $F->{"epconfig:subfield"} }, {
				name => $subfield->{sub_name},
				type => $subfield->{type},
			};
		}
	}

	push @FIELDS, $F;
}

print XMLout(
	{
		epconfig => {
			"xmlns:epconfig" => "http://www.symplectic.co.uk/ep3/config",
			"epconfig:fields" => {
				"epconfig:field" => \@FIELDS,
			},
		},
	},
	RootName => undef,
);


$session->terminate();
