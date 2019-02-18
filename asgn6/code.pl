#!/usr/bin/perl
use Net::SSH;
use strict;
use warnings;
use DBI;
my $tunnelpass = 'isenseven';
my $user = 'kedziora';
my $pass = '2351';
my $dsn = 'dbi:Pg:database=kedziora;host=studentdb.csc.uvic.ca';

my $ssh = Net::SSH->new('kedziora@linux.csc.uvic.ca');
$ssh->login($user, $tunnelpass);
my($stdout, $stderr, $exit) = $ssh->cmd($cmd);

print "variables declared ${user}\n";
my $dbh = DBI->connect($dsn,$user,$pass)
  or die "Connecting: $DBI::errstr";
print "connected\n";
my $sth = $dbh->prepare(qq{
  CREATE TABLE testconnect (
    pid integer PRIMARY KEY,
    pname varchar(40),
    color varchar(20),
  )
})
or die "Could not Create Table: $DBI::errstr";
print "prepared statement\n";
$sth->execute;
print "executed\n";
#disconnect from the database.
$dbh->disconnect();

exit 1;
