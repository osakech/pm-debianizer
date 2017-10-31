# pm-debianizer
**This tool is still in early alpha**

Creates a Debian package for Ubuntu from a CPAN module. Support for more  Debian platforms coming soon.

## Prerequisites
* Docker
* Linux
* Perl 5.10+ should be fine.
* Access to docker, easiest way is with root privileges or have a look at the docker manual.

## CAUTION!
* This tool is not user friendly at the moment and full of bugs
* Only Pure Perl modules will probably work (atm I am just executing "cpan2deb <modulename>" in the docker container)

## OPTIONS:

### -m
The name of perl module you want to export

### -x
Delete previous images

Note: previous containers are deleted by default

### -t
The target platform you want to your package to be build inside.

Note: This argument is passed directly to the [FROM statement of our Dockerfile](https://docs.docker.com/engine/reference/builder/#from). For a list of possible repositories you can visit [Docker Hub](https://hub.docker.com/). Keep in mind that the tool is designed to work with debian based distributions.


## USAGE:

```bash
./pmd.pl -m CPAN::Module -t debianish
```

For example:
```bash
./pmd.pl -m LWP::UserAgent -t debian:buster
```
This will create a folder in your current directory named after your module and the targeted distribution with all the source code and scripts used to build your debian package and hopefully the debian package
```
[root@linux-2 pm-debianizer]# ls -1 LWP\:\:UserAgent_debian:buster/
buildscript.sh
libwww-perl-perl
libwww-perl-perl_6.27-1_all.deb
libwww-perl-perl_6.27.orig.tar.gz
```

## Thanks
Slaven (eserte) for the idea!
