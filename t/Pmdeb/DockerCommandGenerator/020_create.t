# @Author: Alexandros Kechagias <osakech>
# @Date:   31-10-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: 020_create.t
# @Last modified by:   alexandros
# @Last modified time: 12-12-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias
#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests=>4;
use Test::Fatal;
use FindBin;

use lib "$FindBin::Bin/../../../lib";
use Pmdeb::DockerCommandGenerator;

my $gotCommand = Pmdeb::DockerCommandGenerator::create('container','image');
my $expectedCommand = 'docker create  --name container image .';
is($gotCommand,$expectedCommand,"create command looks good");

my $gotCommandWithEnv = Pmdeb::DockerCommandGenerator::create('container','image','env');
my $expectedCommandWithEnv = 'docker create env --name container image .';
is($gotCommandWithEnv,$expectedCommandWithEnv,"create command looks good with env");

like(
  exception{ Pmdeb::DockerCommandGenerator::create('','b') },
  qr{docker create argument container name is missing},
  "die because docker create argument container name is missing"
);

like(
  exception{ Pmdeb::DockerCommandGenerator::create('a','') },
  qr{docker create argument image name is missing},
  "die because docker create argument image name is missing"
);
