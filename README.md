# pm-debianizer
**This tool is still in early alpha**

Creates a Debian package for Ubuntu from a CPAN module.Support for more  Debian platforms coming soon.

## Prerequisites
* Docker
* Linux
* Perl 5.10+ should be fine.
* Access to docker, easiest way is with root privileges or have a look at the docker manual.

## CAUTION!
* This tool is not user friendly at the moment and full of bugs
* Only Pure Perl modules will probably work (atm I am just executing "cpan2deb <modulename>" in the docker container)


## USAGE:

```bash
./pmd.pl -m *<CPAN module name>*
```

For example:
```bash
./pmd.pl -m LWP::UserAgent
```
This will create a folder in your current directory named after your module with all the source code and scripts used to build your debian package and hopefully the debian package
```
[root@linux-2 pm-debianizer]# ls -1 LWP\:\:UserAgent/
buildscript.sh
libwww-perl-perl
libwww-perl-perl_6.27-1_all.deb
libwww-perl-perl_6.27.orig.tar.gz
```
