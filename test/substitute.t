#! /usr/bin/perl
################################################################################
## taskwarrior - a command line task list manager.
##
## Copyright 2006-2012, Paul Beckingham, Federico Hernandez.
##
## Permission is hereby granted, free of charge, to any person obtaining a copy
## of this software and associated documentation files (the "Software"), to deal
## in the Software without restriction, including without limitation the rights
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
## copies of the Software, and to permit persons to whom the Software is
## furnished to do so, subject to the following conditions:
##
## The above copyright notice and this permission notice shall be included
## in all copies or substantial portions of the Software.
##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
## OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
## THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
## SOFTWARE.
##
## http://www.opensource.org/licenses/mit-license.php
##
################################################################################

use strict;
use warnings;
use Test::More tests => 9;

# Create the rc file.
if (open my $fh, '>', 'subst.rc')
{
  print $fh "data.location=.\n",
            "regex=off\n";
  close $fh;
  ok (-r 'subst.rc', 'Created subst.rc');
}

# Test the substitution command.
qx{../src/task rc:subst.rc add foo foo foo};
qx{../src/task rc:subst.rc 1 modify /foo/FOO/};
my $output = qx{../src/task rc:subst.rc info 1};
like ($output, qr/FOO foo foo/, 'substitution in description');

qx{../src/task rc:subst.rc 1 modify /foo/FOO/g};
$output = qx{../src/task rc:subst.rc info 1};
like ($output, qr/FOO FOO FOO/, 'global substitution in description');

# Test the substitution command on annotations.
qx{../src/task rc:subst.rc 1 annotate bar bar bar};
qx{../src/task rc:subst.rc 1 modify /bar/BAR/};
$output = qx{../src/task rc:subst.rc info 1};
like ($output, qr/BAR bar bar/, 'substitution in annotation');

qx{../src/task rc:subst.rc 1 modify /bar/BAR/g};
$output = qx{../src/task rc:subst.rc info 1};
like ($output, qr/BAR BAR BAR/, 'global substitution in annotation');

qx{../src/task rc:subst.rc 1 modify /FOO/aaa/};
qx{../src/task rc:subst.rc 1 modify /FOO/bbb/};
qx{../src/task rc:subst.rc 1 modify /FOO/ccc/};
$output = qx{../src/task rc:subst.rc info 1};
like ($output, qr/aaa bbb ccc/, 'individual successive substitution in description');

qx{../src/task rc:subst.rc 1 modify /bbb//};
$output = qx{../src/task rc:subst.rc info 1};
like ($output, qr/aaa  ccc/, 'word deletion in description');

# Regexes
qx{../src/task rc:subst.rc rc.regex:on 1 modify "/c{3}/CcC/"};
$output = qx{../src/task rc:subst.rc info 1};
like ($output, qr/aaa  CcC/, 'regex');

# Cleanup.
unlink qw(pending.data completed.data undo.data backlog.data synch.key subst.rc);
ok (! -r 'pending.data'   &&
    ! -r 'completed.data' &&
    ! -r 'undo.data'      &&
    ! -r 'backlog.data'   &&
    ! -r 'synch.key'      &&
    ! -r 'subst.rc', 'Cleanup');

exit 0;

