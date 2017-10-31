# @Author: Alexandros Kechagias <osakech>
# @Date:   31-10-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: 060_removeContainer.t
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

my $gotCommand = Pmdeb::DockerCommandGenerator::removeContainer('name');
my $expectedCommand = 'docker rm name';
is($gotCommand,$expectedCommand,"rm command looks good");

like(
  exception{ Pmdeb::DockerCommandGenerator::removeContainer('') },
  qr{docker rm argument container name is missing},
  "die because docker rm argument container name is missing"
);
