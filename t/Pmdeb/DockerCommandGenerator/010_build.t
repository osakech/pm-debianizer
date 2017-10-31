# @Author: Alexandros Kechagias <osakech>
# @Date:   31-10-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: 010_build.t
# @Last modified by:   osakech
# @Last modified time: 31-10-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias


#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests=>3;
use Test::Fatal;
use FindBin;

use lib "$FindBin::Bin/../../../lib";
use Pmdeb::DockerCommandGenerator;

my $gotCommand = Pmdeb::DockerCommandGenerator::build('imagename:version','targetPlatform:version');
my $expectedCommand = 'docker build -t imagename:version -f Dockerfile --build-arg image=targetPlatform:version .';
is($gotCommand,$expectedCommand,"build command looks good");

like(
  exception{ Pmdeb::DockerCommandGenerator::build('','targetPlatform:version') },
  qr{docker build argument image name is missing at},
  "die because docker build argument image name is missing"
);

like(
  exception{ Pmdeb::DockerCommandGenerator::build('imagename:version','') },
  qr{docker build argument target platform is missing at},
  "die because docker build argument target platform is missing"
);
