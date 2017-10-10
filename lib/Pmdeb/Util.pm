package Pmdeb::Util;

use strict;
use warnings;
use feature 'say';
use File::Path 'rmtree';

sub deletePreviousDebs {
  # i don't feel good about this function ...
  my ($opt_m) = @_;
  die if (!$opt_m or $opt_m eq ".");
  rmtree($opt_m);
}

sub destroyAllPreviousImages {
  my ($cname) = @_;
  warn "Destroy all previous images!";
  system("docker image rm $cname\_image");
}

sub destroyAllPreviousContainers {
  my ($cname) = @_;
  say "Destroy all previuos containers!";
  system("docker stop $cname");
  system("docker rm $cname");
}

1;
