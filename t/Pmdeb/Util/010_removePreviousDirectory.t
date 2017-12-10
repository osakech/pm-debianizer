# @Author: Alexandros Kechagias <osakech>
# @Date:   31-10-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: 010_removePreviousDirectory.t
# @Last modified by:   alexandros
# @Last modified time: 30-11-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias
#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use Test::More tests=>6;
use Test::Fatal;
use File::Temp qw(tempdir tempfile);
use File::Spec;
use FindBin;


use lib "$FindBin::Bin/../../../lib";
use Pmdeb::Util;


# delete with relative path
my $systemTmp = File::Spec->tmpdir();

my $delDir = tempdir("modulename_imagenameXXXX",DIR=>$systemTmp);
my ($fh, $filename) = tempfile(DIR=>$delDir);

my ($module,$imageName) = split /\_/, $delDir;

$fh->flush();

is( -e $delDir, 1, "directory $delDir exists before deletion" );

Pmdeb::Util::removePreviousDirectory($module,$imageName);

is( -e $delDir, undef, "directory $delDir deleted successfully" );

# delete with custom output path
my $delDirOdir = tempdir("modulename_imagenameXXXX",DIR=>$systemTmp);
my ($fhOdir, $filenameOdir) = tempfile(DIR=>$delDirOdir);


my ($pathtmpOdir,$imageNameOdir) = split /\_/, $delDirOdir;

my (undef,$customOdir,$moduleNameOdir ) = File::Spec->splitpath($pathtmpOdir);

$fhOdir->flush();

is( -e $delDirOdir, 1, "directory $delDirOdir exists before deletion with output dir set" );

Pmdeb::Util::removePreviousDirectory('modulename',$imageNameOdir,$customOdir);

is( -e $delDirOdir, undef, "directory $delDirOdir deleted successfully with output dir set" );

# exceptions
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
