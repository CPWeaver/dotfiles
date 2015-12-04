#!/usr/bin/perl

my %cols = {};

while (<>) {
  chomp;
  my ($day, $time, $level, $thread, $class, $stat, $ssrc, $value) = split / /;
  my $key = "$stat" . "_" . "$ssrc";
  if (not exists $cols{$key}) {
    $cols{$key} = keys(%cols);
  }
  print "\n$day $time,$key:$cols{$key}";
  for (my $c=1; $c < keys(%cols); $c++) {
    print ",";
    if ($cols{$key} eq $c) {
      print $value;
    }
  }
}
