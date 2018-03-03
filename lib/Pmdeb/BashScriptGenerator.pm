# @Author: Alexandros Kechagias <osakech>
# @Date:   11-10-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: BashScriptGenerator.pm
# @Last modified by:   alexandros
# @Last modified time: 13-12-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias



package Pmdeb::BashScriptGenerator;

use strict;
use warnings;


sub getScriptContents {
  my ($pkgname) = @_;

  return qq{
  #!/usr/bin/sh
  git config --global user.email osakech\@gmail.com

  DEB_BUILD_OPTIONS=nocheck cpan2deb $pkgname --core-ok
  };
}

1;
