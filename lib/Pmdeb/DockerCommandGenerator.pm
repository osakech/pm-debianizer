# @Author: Alexandros Kechagias <osakech>
# @Date:   31-10-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: DockerCommandExecutor.pm
# @Last modified by:   alexandros
# @Last modified time: 22-12-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias



package Pmdeb::DockerCommandGenerator;
use strict;
use warnings;
use Carp;
use feature 'say';
use File::Spec;
use Cwd 'realpath';

sub build {
  my ( $imageName, $targetPlatform ) = @_;
  croak "docker build argument image name is missing" unless $imageName;
  croak "docker build argument target platform is missing"  unless $targetPlatform;

  return "docker build -t $imageName -f Dockerfile --build-arg image=$targetPlatform .";
}

sub create {
  my ( $containerName, $imageName, $envParams ) = @_;
  croak "docker create argument container name is missing" unless $containerName;
  croak "docker create argument image name is missing"  unless $imageName;

  return "docker create ".($envParams || '')." --name $containerName $imageName .";
}

sub cp {
  my ( $containerName, $moduleName, $targetPlatform, $outputDirectory ) = @_;
  croak "docker cp argument container name is missing" unless $containerName;
  croak "docker cp argument module name is missing" unless $moduleName;
  croak "docker cp argument target platform is missing"  unless $targetPlatform;

  my $rpath = realpath(File::Spec->catfile($outputDirectory // ".","$moduleName\_$targetPlatform"));
  return "docker cp $containerName:/workdir $rpath";
}

sub removeImage {
  my ($imageName) = @_;
  croak "docker image rm argument image name is missing" unless $imageName;

  return "docker image rm $imageName";
}

sub stopContainer {
  my ($containerName) = @_;
  croak "docker stop argument container name is missing" unless $containerName;

  return "docker stop $containerName";
}

sub removeContainer {
  my ($containerName) = @_;
  croak "docker rm argument container name is missing" unless $containerName;

  return "docker rm $containerName";
}

sub getEnvParams {
  my $envParams;
  for my $env_key (qw(DEBFULLNAME DEBEMAIL EMAIL)) {
	    if ($ENV{$env_key}) {
        $envParams .= "--env $env_key=\"$ENV{$env_key}\" "
      }
	}
  return $envParams;
}

1;
