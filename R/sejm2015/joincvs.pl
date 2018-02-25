#!/usr/bin/perl
#
use Getopt::Long;

print STDERR ("*** $0 -f1 FILE -c1 NUM -f2 FILE -c2 NUM\n");
GetOptions("f1=s" => \$File1, "c1=s" => \$Col1, "f2=s" => \$File2, "c2=s" => \$Col2);

open (F1, "$File1") || die "*** Cannot open $File1\n";
while (<F1>) { chomp(); @tmp1=split (/;/, $_); $F1{$tmp1[$Col1]} = $_; }
close(F1);

open (F2, "$File2") || die "### Cannot open $File2\n";
while (<F2>) { chomp(); @tmp2=split (/;/, $_); 
  if (exists $F1{$tmp2[$Col2]}) {  print $F1{$tmp2[$Col2]} . ";" . $_ . "\n"; }
  else { warn "**No match**\n"; print "***;$_\n"; }
}
close(F2);
