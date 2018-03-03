# @Author: Alexandros Kechagias <osakech>
# @Date:   31-10-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: 010_getScriptContents.t
# @Last modified by:   alexandros
# @Last modified time: 22-12-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias

#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 1;
use FindBin;

use lib "$FindBin::Bin/../../../lib";
use Pmdeb::BashScriptGenerator;

my $got = Pmdeb::BashScriptGenerator::getScriptContents("Some::Package::Name");

my $expected = qq{
  #!/usr/bin/sh
  git config --global user.email osakech\@gmail.com
  DEB_BUILD_OPTIONS=nocheck cpan2deb Some::Package::Name --core-ok
  };

is($got,$expected,"generated script looks good");
