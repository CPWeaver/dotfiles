#!/usr/bin/perl

while (<>) {
   if (/<event-id>(.*)<\/event-id>/) {
      print "id: $1\n";
   }
}
