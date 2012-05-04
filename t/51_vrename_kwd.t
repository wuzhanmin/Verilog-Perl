#!/usr/bin/perl -w
# DESCRIPTION: Perl ExtUtils: Type 'make test' to test this package
#
# Copyright 2000-2012 by Wilson Snyder.  This program is free software;
# you can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License Version 2.0.

use strict;
use Test::More;

BEGIN { plan tests => 4 }
BEGIN { require "t/test_utils.pl"; }

print "Checking vrename...\n";
my $changefile = "test_dir/51_vrename_kwd_list.vrename";
{
    # -List
    my $cmd = "${PERL} ./vrename -changefile=$changefile -list --changelang --language 1364-1995 t/51_vrename_kwd.v";
    run_system ($cmd);
    ok(1, "vrename list");
    ok(files_identical($changefile, "t/51_vrename_kwd_list.out"), "diff");
}

{
    # Try renaming
    mkdir 'test_dir/t', 0777;
    my $cmd = ("${PERL} ./vrename -change --changefile=$changefile"
	       ." -o test_dir t/51_vrename_kwd.v");
    run_system ($cmd);
    ok(1, "vrename change");
    ok(files_identical("test_dir/t/51_vrename_kwd.v", "t/51_vrename_kwd_chg.out"), "diff");
}