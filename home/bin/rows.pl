#!/usr/bin/perl

my %colByStat = {};
my %statByCol = {};

while (<>) {
  chomp;
  my ($day, $time, $level, $thread, $class, $marker, $statsString) = split / /;
  my @stats = split /,/, $statsString;
  my %statHash = {};
  foreach my $stat (@stats) {
    my ($statKey, $statValue) = split /:/, $stat;
    if (not exists $colByStat{$statKey}) {
      $colByStat{$statKey} = keys(%colByStat);
      $statByCol{$colByStat{$statKey}} = $statKey
    }
    $statHash{$colByStat{$statKey}} = $statValue;
  }
  print "\n$day $time";
  for (my $c=1; $c < keys(%colByStat); $c++) {
    print ",$statHash{$c}";
  }
}
