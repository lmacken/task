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
use Test::More tests => 5;

# Create the rc file.
if (open my $fh, '>', 'recur.rc')
{
  print $fh "data.location=.\n",
            "recurrent.limit=1\n";
  close $fh;
  ok (-r 'recur.rc', 'Created recur.rc');
}

# Create a recurring and non-recurring task.
qx{../src/task rc:recur.rc add simple};
qx{../src/task rc:recur.rc add complex due:today recur:daily};

# List tasks to generate child tasks.  Should result in:
#   1 simple
#   3 complex
#   4 complex
my $output = qx{../src/task rc:recur.rc minimal};
like ($output, qr/1.+simple$/ms, '1 simple');
like ($output, qr/3.+complex$/ms, '3 complex');
like ($output, qr/4.+complex$/ms, '4 complex');

# TODO Modify a child task and do not propagate the change.
$output = qx{echo '-- n' | ../src/task rc:recur.rc 3 modify complex2};
diag ('---');
diag ($output);
diag ('---');

# TODO Modify a child task and propagate the change.
$output = qx{echo '-- y' | ../src/task rc:recur.rc 3 modify complex2};
diag ('---');
diag ($output);
diag ('---');

# TODO Delete a child task.
$output = qx{echo '-- n' | ../src/task rc:recur.rc 3 delete};
diag ('---');
diag ($output);
diag ('---');

# TODO Delete a recurring task.
$output = qx{echo '-- y' | ../src/task rc:recur.rc 4 delete};
diag ('---');
diag ($output);
diag ('---');

# TODO Wait a recurring task
# TODO Upgrade a task to a recurring task
# TODO Downgrade a recurring task to a regular task
# TODO Duplicate a recurring child task
# TODO Duplicate a recurring parent task

# Cleanup.
unlink qw(pending.data completed.data undo.data backlog.data synch.key recur.rc);
ok (! -r 'pending.data'   &&
    ! -r 'completed.data' &&
    ! -r 'undo.data'      &&
    ! -r 'backlog.data'   &&
    ! -r 'synch.key'      &&
    ! -r 'recur.rc', 'Cleanup');

exit 0;

