# @Author: Alexandros Kechagias <osakech>
# @Date:   31-10-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: Util.pm
# @Last modified by:   alexandros
# @Last modified time: 30-11-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias



package Pmdeb::Util;

use strict;
use warnings;
use feature 'say';
use File::Path 'remove_tree';
use File::Spec;
use FindBin;
use Cwd 'realpath';
use Carp;

sub removePreviousDirectory {
  # i don't feel good about this function ...
  my ($moduleName, $targetPlatform, $outputdir) = @_;
  croak "missing module name" unless ($moduleName);
  croak "missing target platform" unless $targetPlatform;
  my $rpath = realpath( File::Spec->catdir($outputdir // '', "$moduleName\_$targetPlatform") );


  croak "Will not delete root!" if ($rpath eq "/");
  say "deleting previous directory : ". $rpath;

  remove_tree($rpath, {safe=>1} );
}

1;
