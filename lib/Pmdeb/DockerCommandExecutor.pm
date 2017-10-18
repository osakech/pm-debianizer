package Pmdeb::DockerCommandExecutor;
use strict;
use warnings;
use feature 'say';

sub build {
  my ( $imageName, $targetPlatform ) = @_;
  my $bCont = "docker build -t $imageName -f Dockerfile --build-arg image=$targetPlatform .";  
  say "command -> ".$bCont;
  system($bCont);
  say "finished building image";
}

sub create {
  my ( $containerName, $imageName ) = @_;
  my $cCont = "docker create --name $containerName $imageName .";
  say "command -> ".$cCont;
  system($cCont);
  say "created docker container";
}

sub cp {
  my ( $containerName, $moduleName ) = @_;
  my $copCont = "docker cp $containerName:/workdir ./$moduleName";
  say "command -> ".$copCont;
  system($copCont);
  say "workdir copied";
}

1;