#!/usr/bin/perl
# @Author: Alexandros Kechagias <osakech>
# @Date:   31-10-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: pmd.pl
# @Last modified by:   alexandros
# @Last modified time: 29-11-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias

return 1 if caller();

use strict;
use warnings;
use feature 'say';
use Getopt::Std;

use FindBin;

use lib "$FindBin::Bin/lib";

use Pmdeb::BashScriptGenerator;
use Pmdeb::Util;
use Pmdeb::DockerCommandGenerator;

use constant CONTAINER_NAME => 'pmdeb-cont';
use constant IMAGE_NAME => 'pmdeb-cont_image';
use constant BUILD_SCRIPT_PATH => 'buildscript.sh';

our ($opt_m, $opt_x, $opt_t, $opt_o);
getopts('xm:t:o:');

open(my $fh, ">", BUILD_SCRIPT_PATH) or die "Can't open > BUILD_SCRIPT_PATH: $!";
print $fh Pmdeb::BashScriptGenerator::getScriptContents($opt_m);
close $fh;


system(Pmdeb::DockerCommandGenerator::stopContainer(CONTAINER_NAME));
system(Pmdeb::DockerCommandGenerator::removeContainer(CONTAINER_NAME));

system(Pmdeb::DockerCommandGenerator::removeImage(IMAGE_NAME)) if($opt_x);

my $buildCommand = Pmdeb::DockerCommandGenerator::build( IMAGE_NAME, $opt_t );
say "docker build command -> ".$buildCommand;
system($buildCommand);
say "finished building image";

my $createCommand = Pmdeb::DockerCommandGenerator::create( CONTAINER_NAME, IMAGE_NAME );
say "docker create command -> ".$createCommand;
system($createCommand);
say "finished creating container";

Pmdeb::Util::removePreviousDirectory($opt_m, $opt_t, $opt_o);

my $copyCommand = Pmdeb::DockerCommandGenerator::cp( CONTAINER_NAME, $opt_m, $opt_t, $opt_o );
say "docker copy command -> ".$copyCommand;
system($copyCommand);
say "finished copying workdir out of the container";


exit;
