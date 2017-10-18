package Pmdeb::Util;

use strict;
use warnings;
use feature 'say';
use File::Path 'rmtree';

sub deletePreviousDebs {
  # i don't feel good about this function ...
  my ($moduleName) = @_;
  die if (!$moduleName or $moduleName eq ".");
  rmtree($moduleName);
}

sub destroyAllPreviousImages {
  my ($imageName) = @_;
  warn "Destroy all previous images!";
  system("docker image rm $imageName");
}

sub destroyAllPreviousContainers {
  my ($containerName) = @_;
  say "Destroy all previuos containers!";
  system("docker stop $containerName");
  system("docker rm $containerName");
}

1;
