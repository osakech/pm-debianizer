# @Author: Alexandros Kechagias <alexandros>
# @Date:   04-11-2017
# @Email:  osakech@gmail.com
# @Project: pm-debianizer
# @Filename: 001_does_it_blend.t
# @Last modified by:   alexandros
# @Last modified time: 04-11-2017
# @License: GPLv3
# @Copyright: Copyright 2017 Alexandros Kechagias

use strict;
use warnings;
use feature 'say';

use Test::More;
use File::Find;

use FindBin;
use lib "$FindBin::Bin/../../lib/";

my $options = {
    wanted   => \&wanted,
    no_chdir => 1,
};

find( $options, "$FindBin::Bin/../../" );

my @myPMS;
my @myPLS;
my @myTS;

sub wanted {

    return if ( -d $File::Find::name );
    if (/\.pm$/) {
        my $mymodules_file_name = $File::Find::name;    # input file name

        open my $mymodules, '<', $mymodules_file_name
          or die "$0 : failed to open  input file '$mymodules_file_name' : $!\n";

        while (<$mymodules>) {
            if (/^package\s+(Pmdeb[[:alnum:]:]+)\s*;/) {
                push @myPMS, $1;
                last;
            }
        }

        close $mymodules
          or warn "$0 : failed to close input file '$mymodules_file_name' : $!\n";
    } elsif (/\.pl$/) {
        my $myscripts_file_name = $File::Find::name;    # input file name

        open my $myscripts, '<', $myscripts_file_name
          or die "$0 : failed to open  input file '$myscripts_file_name' : $!\n";

        while (<$myscripts>) {
            if (/^return 1 if caller\(\);/) {
                push @myPLS, $File::Find::name;
                last;
            }
        }

        close $myscripts
          or warn "$0 : failed to close input file '$myscripts_file_name' : $!\n";

    } elsif (/\.t$/) {
        return if (/$0/);
        push @myTS, $File::Find::name;
    }

}

foreach my $mod ( @myPMS, @myPLS ) {
    note 'testing' . $mod;
    require_ok $mod;
}

done_testing();
