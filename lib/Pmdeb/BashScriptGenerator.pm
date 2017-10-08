package Pmdeb::BashScriptGenerator;

use strict;
use warnings;


sub getScriptContents {
  my ($pkgname) = @_;

  return qq{
  #!/usr/bin/sh
  git config --global user.email osakech\@gmail.com
  DEB_BUILD_OPTIONS=nocheck cpan2deb $pkgname  
  };
}

1;
