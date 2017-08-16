#!/usr/bin/env perl

use Moose;
use Data::Dumper;
use Cwd;

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
with 'TestHelper';

$ENV{PATH} .= ":../bin";

BEGIN {
    use Test::Most;
    use_ok('Bio::Deago::CommandLine::BuildDeagoConfig');
}

my $script_name = 'Bio::Deago::CommandLine::BuildDeagoConfig';
my $cwd         = getcwd();
system('touch empty_file');
my %scripts_and_expected_files = (
#    't/data/example_annotation.gff' =>
#      ['example_annotation.gff.proteome.faa','t/data/example_annotation.gff.proteome.faa.expected' ],
#      '-t 1 t/data/example_annotation.gff' =>
#        ['example_annotation.gff.proteome.faa','t/data/example_annotation.gff.proteome.faa.expected' ],
      '-h' =>
        [ 'empty_file', 't/data/empty_file' ],
);

stdout_should_have($script_name,'', 'Error: You need to provide');

mock_execute_script_and_check_output( $script_name, \%scripts_and_expected_files );


done_testing();
