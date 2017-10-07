#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use Getopt::Std;

use FindBin;

use lib "$FindBin::Bin/lib";

use Pmdeb::BashScriptGenerator;

our ($opt_m);
getopts('m:');

my $script = Pmdeb::BashScriptGenerator::getScriptContents($opt_m);

open(my $fh, ">", "buildscript.sh") or die "Can't open > output.txt: $!";
print $fh $script;
close $fh;

my $containerName = "pmdeb-cont";

my $bCont = "docker build . -t $containerName -f Dockerfile";
say "command -> ".$bCont;
system($bCont);
say "finished building container";

system ("docker stop $containerName");
system ("docker rm $containerName");

my $cCont = "docker create --name $containerName $containerName .";
say "command -> ".$cCont;
system($cCont);
say "created docker container";

my $copCont = "docker cp $containerName:/workdir ./$opt_m";
say "command -> ".$copCont;
system($copCont);

say "finished";
exit;
