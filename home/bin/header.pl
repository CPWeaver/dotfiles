#!/usr/bin/perl

my %cols = {};
my %keys = {};

while (<>) {
  chomp;
  my ($day, $time, $level, $thread, $class, $stat, $ssrc, $value) = split / /;
  my $key = "$stat" . "_" . "$ssrc";
  if (not exists $cols{$key}) {
    $cols{$key} = keys(%cols);
    $keys{$cols{$key}} = $key;
  }
}

print "time,name";
for (my $k=1; $k < keys(%keys); $k++) {
  print ",";
  print $keys{$k};
}
