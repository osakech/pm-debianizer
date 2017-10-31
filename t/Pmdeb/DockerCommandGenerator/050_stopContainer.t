# @Author: Alexandros Kechagias <osakech>
# @Date:   31-10-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: 050_stopContainer.t
# @Last modified by:   osakech
# @Last modified time: 31-10-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias

use strict;
use warnings;
use Test::More tests=>2;
use Test::Fatal;
use FindBin;

use lib "$FindBin::Bin/../../../lib";
use Pmdeb::DockerCommandGenerator;

my $gotCommand = Pmdeb::DockerCommandGenerator::stopContainer('name');
my $expectedCommand = 'docker stop name';
is($gotCommand,$expectedCommand,"stop command looks good");

like(
  exception{ Pmdeb::DockerCommandGenerator::stopContainer('') },
  qr{docker stop argument container name is missing},
  "die because docker stop argument container name is missing"
);
