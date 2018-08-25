#!/usr/bin/perl

# Copyright 2018 Michael Schlenstedt, michael@loxberry.de
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


##########################################################################
# Modules
##########################################################################
use Config::Simple '-strict';
use CGI::Carp qw(fatalsToBrowser);
use CGI;
use LoxBerry::System;
use warnings;
use strict;

##########################################################################
# Read Settings
##########################################################################

# Version of this script
my $version = "0.0.1";

# Read Form
my $cgi = CGI->new;
$cgi->import_names('R');

# Read settings
my $cfg = new Config::Simple("$lbpconfigdir/mirobot2lox-ng.cfg");

##########################################################################
# Main program
##########################################################################

print "Content-Type: text/plain\n\n";

# Everything from URL
#foreach (split(/&/,$ENV{'QUERY_STRING'}))
#{
#  ($namef,$value) = split(/=/,$_,2);
#  $namef =~ tr/+/ /;
#  $namef =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
#  $value =~ tr/+/ /;
#  $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
#  $query{$namef} = $value;
#}

#  print "/usr/bin/sudo $installfolder/data/plugins/$psubfolder/bin/send433 -p=$transPIN $pulselength $family $group $unit $command\n\n";
#  our $output = qx(/usr/bin/sudo $installfolder/data/plugins/$psubfolder/bin/send433 -p=$transPIN $pulselength $family $group $unit $command 2>&1);
#  if ( $? ne 0 ) {
#    $send = 1;
#    print "ERROR - Somehting went wrong. Could not send command. This is the error message: ";
#  } else {
#    $send = 1;
#    print "OK:\n";
#    our $output1 = qx(/usr/bin/sudo $installfolder/data/plugins/$psubfolder/bin/send433 -p=$transPIN $pulselength $family $group $unit $command 2>&1);
#    our $output2 = qx(/usr/bin/sudo $installfolder/data/plugins/$psubfolder/bin/send433 -p=$transPIN $pulselength $family $group $unit $command 2>&1);
#  }


