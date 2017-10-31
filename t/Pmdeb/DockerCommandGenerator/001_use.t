# @Author: Alexandros Kechagias <osakech>
# @Date:   31-10-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: 001_use.t
# @Last modified by:   osakech
# @Last modified time: 31-10-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias


#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 1;
use FindBin;
use lib "$FindBin::Bin/../../../lib";

use_ok("Pmdeb::DockerCommandGenerator");
