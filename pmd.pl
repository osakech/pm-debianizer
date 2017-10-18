#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use Getopt::Std;

use FindBin;

use lib "$FindBin::Bin/lib";

use Pmdeb::BashScriptGenerator;
use Pmdeb::Util;
use Pmdeb::DockerCommandExecutor;

use constant CONTAINER_NAME => 'pmdeb-cont';
use constant IMAGE_NAME => 'pmdeb-cont_image';
use constant BUILD_SCRIPT_PATH => 'buildscript.sh';

our ($opt_m, $opt_x, $opt_t);
getopts('xm:t:');

open(my $fh, ">", BUILD_SCRIPT_PATH) or die "Can't open > BUILD_SCRIPT_PATH: $!";
print $fh Pmdeb::BashScriptGenerator::getScriptContents($opt_m);
close $fh;

Pmdeb::Util::destroyAllPreviousContainers(CONTAINER_NAME);
Pmdeb::Util::destroyAllPreviousImages(IMAGE_NAME) if($opt_x);

Pmdeb::DockerCommandExecutor::build( IMAGE_NAME, $opt_t );
Pmdeb::DockerCommandExecutor::create( CONTAINER_NAME, IMAGE_NAME );

Pmdeb::Util::deletePreviousDebs($opt_m);

Pmdeb::DockerCommandExecutor::cp( CONTAINER_NAME, $opt_m );

exit;
