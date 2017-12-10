# @Author: Alexandros Kechagias <osakech>
# @Date:   31-10-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: 030_cp.t
# @Last modified by:   alexandros
# @Last modified time: 10-12-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias
#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests=>5;
use Test::Fatal;
use FindBin;
use Cwd 'realpath';
use File::Spec;


use lib "$FindBin::Bin/../../../lib";
use Pmdeb::DockerCommandGenerator;

my $gotCommand = Pmdeb::DockerCommandGenerator::cp('container','module','platform');
my $rpath = realpath(File::Spec->catfile('.' , 'module_platform'));
my $expectedCommand = "docker cp container:/workdir $rpath";
is($gotCommand,$expectedCommand,"cp command looks good");

my $tmpdir = File::Spec->tmpdir();
my $gotCommandWithOdir = Pmdeb::DockerCommandGenerator::cp('container','module','platform',$tmpdir);
my $rpathWithOdir = realpath(File::Spec->catfile($tmpdir,'module_platform'));
my $expectedCommandWithOdir = "docker cp container:/workdir $rpathWithOdir";
is($gotCommandWithOdir,$expectedCommandWithOdir,"cp command looks good with custom outputdir");




like(
  exception{ Pmdeb::DockerCommandGenerator::cp('','b','c') },
  qr{docker cp argument container name is missing},
  "die because docker cp argument container name is missing"
);

like(
  exception{ Pmdeb::DockerCommandGenerator::cp('a','','c') },
  qr{docker cp argument module name is missing},
  "die because docker cp argument module name is missing"
);

like(
  exception{ Pmdeb::DockerCommandGenerator::cp('a','b','') },
  qr{docker cp argument target platform is missing},
  "die because docker cp argument target platform is missing"
);
