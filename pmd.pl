#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use Getopt::Std;

use FindBin;

use lib "$FindBin::Bin/lib";

use Pmdeb::BashScriptGenerator;
use Pmdeb::Util;


our ($opt_m, $opt_x);
getopts('xm:,');

my $script = Pmdeb::BashScriptGenerator::getScriptContents($opt_m);

open(my $fh, ">", "buildscript.sh") or die "Can't open > output.txt: $!";
print $fh $script;
close $fh;

my $containerName = "pmdeb-cont";

Pmdeb::Util::destroyAllPreviousContainers($containerName);
Pmdeb::Util::destroyAllPreviousImages($containerName) if($opt_x);

my $bCont = "docker build -t $containerName\_image -f Dockerfile .";
say "command -> ".$bCont;
system($bCont);
say "finished building image";


my $cCont = "docker create --name $containerName $containerName\_image .";
say "command -> ".$cCont;
system($cCont);
say "created docker container";


Pmdeb::Util::deletePreviousDebs($opt_m);
my $copCont = "docker cp $containerName:/workdir ./$opt_m";
say "command -> ".$copCont;
system($copCont);

say "finished";
exit;
