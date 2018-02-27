#!/usr/bin/perl
#
use Getopt::Long;
print STDERR ("*** $0 -c NUM\n");
GetOptions("c=i" => \$Col);

my %ScaleNormalT = ( 5 => 'measle_white', 10 => 'measle_grey', 
 25 => 'small_yellow', 50 => 'measle_brown', 100 => 'small_blue', 200 => 'small_purple',
 10000 => 'small_red', );
## LowTurout (Hojarska na przykład)
my %ScaleLowT = ( 5 => 'measle_white', 10 => 'measle_grey', 20 => 'small_yellow', 
 100 => 'small_red', 10000 => 'small_purple', );
my %Scale = %ScaleNormalT;

$hdr = <>; chomp($hdr); print "$hdr;icon\n";

while (<>) { chomp();  @tmp = split /;/, $_; $val = $tmp[$Col];
  for $scale_break (sort { $b <=> $a } keys %Scale ) {
     if ($val <= $scale_break ) { $icon = $Scale{$scale_break} } }
  print "$_;$icon\n";
}
