package Pmdeb::BashScriptGenerator;

use strict;
use warnings;


sub getScriptContents {
  my ($pkgname) = @_;

  return qq{
  #!/usr/bin/sh
  git config --global user.email osakech\@gmail.com
  dh-make-perl --cpan  $pkgname;
  dh-make-perl \$(find -maxdepth 1 -type d -iname "*$pkgname*");
  cd \$(find -maxdepth 1 -type d -iname "*$pkgname*");
  debuild
  exit 0
  };
}

1;
