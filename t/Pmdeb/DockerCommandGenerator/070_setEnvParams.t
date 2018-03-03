# @Author: Alexandros Kechagias <alexandros>
# @Date:   12-12-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: 070_setEnvParams.t
# @Last modified by:   alexandros
# @Last modified time: 12-12-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias

use strict;
use warnings;
use Test::More tests=>2;

use FindBin;

use lib "$FindBin::Bin/../../../lib";
use Pmdeb::DockerCommandGenerator;

$ENV{DEBFULLNAME} = 'John Doe';
$ENV{DEBEMAIL} = 'debemail@test.com';
$ENV{EMAIL} = 'email@test.com';

my $envString = Pmdeb::DockerCommandGenerator::getEnvParams();

is($envString,'--env DEBFULLNAME="John Doe" --env DEBEMAIL="debemail@test.com" --env EMAIL="email@test.com" ');


$ENV{DEBFULLNAME} = undef;
$ENV{DEBEMAIL} = undef;
$ENV{EMAIL} = undef;

my $envString2 = Pmdeb::DockerCommandGenerator::getEnvParams();

is($envString2,undef,'empty if nothing is set');
