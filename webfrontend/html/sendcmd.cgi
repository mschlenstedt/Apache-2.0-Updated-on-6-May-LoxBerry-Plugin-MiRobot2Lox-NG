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
use URI::Encode qw(uri_encode uri_decode);
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
my $cfg = new Config::Simple("$lbpconfigdir/mirobot2lox.cfg");

##########################################################################
# Main program
##########################################################################

print "Content-Type: text/plain\n\n";

# Clean CGI values
my $command = uri_decode($R::command);
my $robot = uri_decode($R::robot);
my $option = uri_decode($R::option);
my $debug = uri_decode($R::debug);

# Checks
if ( !$command ) {
	print "Awaiting your commands, master.\n";
	print "Please define a command with &command=X";
	exit 1;
}
if ( !$robot ) {
	print "Please define a robot with &robot=X";
	exit 1;
}
if ( $robot > 4 ) {
	print "Only 4 robots are supported.";
	exit 1;
}
if ( !$cfg->param("ROBOT" . $robot . ".ACTIVE") ) {
	print "Robot $robot is not active.";
	exit 1;
}
if ( $debug) {
	$debug = "-d";
} else {
	$debug = "";
}

my $ip = $cfg->param("ROBOT" . $robot . ".IP");
my $token = $cfg->param("ROBOT" . $robot . ".TOKEN");

print "mirobo --ip $ip --token $token $debug $command $option\n\n";
system("$lbpbindir/mirobo_wrapper.sh $ip $token $debug $command $option");

exit 0;
