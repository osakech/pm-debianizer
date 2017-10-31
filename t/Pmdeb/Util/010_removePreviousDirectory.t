# @Author: Alexandros Kechagias <osakech>
# @Date:   31-10-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: 010_removePreviousDirectory.t
# @Last modified by:   osakech
# @Last modified time: 01-11-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias
#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use Test::More tests=>3;
use Test::Fatal;
use File::Temp qw(tempdir tempfile);
use File::Spec;
use FindBin;


use lib "$FindBin::Bin/../../../lib";
use Pmdeb::Util;

my $systemTmp = File::Spec->tmpdir();

my $delDir = tempdir("modulenane_imagenameXXXX",DIR=>$systemTmp);
my ($fh, $filename) = tempfile(DIR=>$delDir);

my ($module,$imageName) = split /\_/, $delDir;

$fh->flush();

Pmdeb::Util::removePreviousDirectory($module,$imageName);

is( -e $delDir, undef, "directory deleted successfully" );

like(
  exception{ Pmdeb::Util::removePreviousDirectory('','targetPlatform') },
  qr{missing module name},
  "die because module name is missing"
);

like(
  exception{ Pmdeb::Util::removePreviousDirectory('moduleName','') },
  qr{missing target platform},
  "die because target platform is missing"
);

# check if it's possible to delete the root dir !!
