#!/usr/bin/perl

my %colByStat = {};
my %statByCol = {};

while (<>) {
  chomp;
  my ($day, $time, $level, $thread, $class, $marker, $statsString) = split / /;
  my @stats = split /,/, $statsString;
  foreach my $stat (@stats) {
    my ($statKey, $statValue) = split /:/, $stat;
    if (not exists $colByStat{$statKey}) {
      $colByStat{$statKey} = keys(%colByStat);
      $statByCol{$colByStat{$statKey}} = $statKey;
    }
  }
}

print "time";
for (my $k=1; $k < keys(%statByCol); $k++) {
  print ",$statByCol{$k}";
}
