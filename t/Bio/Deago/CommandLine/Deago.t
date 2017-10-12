#!/usr/bin/env perl

use Moose;
use Data::Dumper;
use Cwd qw(abs_path getcwd); 

BEGIN { unshift( @INC, './lib' ) }
BEGIN { unshift( @INC, './t/lib' ) }
with 'TestHelper';
with 'ConfigTestHelper';

$ENV{PATH} = join(':', ("$ENV{PATH}", abs_path('../bin')));

BEGIN {
    use Test::Most;
    use_ok('Bio::Deago::CommandLine::Deago');
}

my $script_name = 'Bio::Deago::CommandLine::Deago';
my $cwd         = getcwd();
system('touch empty_file');

build_default_config_file( 'expected_default_deago.config' );
#my $markdown_cmd = "build_deago_markdown -c expected_default_deago.config";
#system($markdown_cmd);

my %scripts_and_expected_files = (
#      '-i expected_default_deago.config'																	=> [ 'deago_markdown.Rmd' ],
#      '-i expected_default_deago.config -o deago_markdown.out.html'				=> [ 'deago_markdown.out.html' ],
#      '-i expected_default_deago.config -o deago_markdown.out.html -d t'	=> [ 't/deago_markdown.out.html' ],
#      '-h' => [ 'empty_file', 't/data/empty_file' ],
);

stdout_should_have( $script_name, '',																		'Error: You need to provide or build a configuration file' );
stdout_should_have( $script_name, '--config_file badConfig', 						'Error: Error: Configuration file does not exist' );
#stdout_should_have( $script_name, '-i bad_markdown', 										'Error: Cannot find markdown file' );
#stdout_should_have( $script_name, '-c deago_markdown.Rmd  -d badDir', 	'Error: Could not find output directory for html file' );

mock_execute_script_and_check_output( $script_name, \%scripts_and_expected_files );

unlink( 'expected_default_deago.config' );
#unlink( 'deago_markdown.Rmd' );
unlink( 'empty_file' );

done_testing();