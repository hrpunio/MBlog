#!/usr/bin/perl

print STDERR "** Użycie: $0 plik numer-kolumny (pierwszy wiersz jest pomijany)\n";
print STDERR "** Domyślnie: wyniki kandydata nr1 na liście komitetu Z.Stonoga (okr.25 / D.Hojarska)\n";

$file = "hojarska.csv"; ## default file
$column = 1; ## first column = 0

if ( $#ARGV >= 0 ) { $file=$ARGV[0]; } 
if ( $#ARGV >= 1 ) { $column=$ARGV[1]; } 

open (S, "$file") || die "Cannot open $file\n";

print "\nDane z pliku $file (kolumna: $column):\n"; 
$hdr = <S> ; # wczytaj i pomin naglowek ($n będzie prawidłowe)
while (<S>) { chomp();
  @tmp = split (/;/, $_); 
  $v = $tmp[$column];
   push(@L, $v) ; 
   $sum += $v; 
   $Counts{"$v"}++;
   $n++;
}

# Wyznaczenie średniej:
$mean = $sum /$n; 

## Wyznaczenie dominanty:
## przy okazji wydrukowanie danych pogrupowanych
print "+--------+---------+--------+--------+-------+--------+\n";
print "| Głosy  | Obwody  |  cumGł | cumGł% |  cumN |  cumN% |\n";
print "+--------+---------+--------+--------+-------+--------+\n";
$maxc = -1;
for $c (sort {$a <=> $b } keys %Counts ) { 
  $sumCum += $Counts{"$c"} * $c; 
  $nCum += $Counts{"$c"}; 
  if ($maxc_pos < $Counts{$c} ) { 
    $maxc_pos = $Counts{$c} ; $maxc_val = $c
  }
  printf "| %6d |  %6d | %6d | %6.2f | %5d | %6.2f |\n", 
    $c,  $Counts{$c}, $sumCum, $sumCum/$sum *100, $nCum, $nCum/$n *100;
}
print "+--------+---------+--------+--------+-------+--------+\n\n";

$mode = $maxc_val; # dominanta

## Wyznaczenie mediany:
$half = int(($#L +1)/2 );
@L = sort ({ $a <=> $b } @L) ; #numerycznie
##print "$half of @L\n";
$median = $L[$half];

printf "Średnie: x̄ = %.3f (N=%d) Me =%.3f D = %.3f\n", $mean, $n, $median, $mode;

## Odchylenia od średniej:
for my $l (@L) {##
  $sd1 = ($l - $mean) ; 
  $sd2 = $sd1 * $sd1; # ^2 
  $sd3 = $sd2 * $sd1; # ^3

  $sum_sd1 += $sd1; $sum_sd2 += $sd2;
  $sum_sd3 += $sd3;
}

# odchylenie std./3-ci moment:
$sd = sqrt(($sum_sd2 / $n)); 
$u3 = $sum_sd3/$n;

printf "Sumy (x-x̄): %.2f(¹) %.2f(²) %.2f(³)\n", 
   $sum_sd1, $sum_sd2, $sum_sd3;
printf "Rozproszenie: σ = %.3f µ³ = %.3f\n", $sd, $u3;

printf "Skośność: (x̄-D)/σ = %.2f", ($mean -$mode)/$sd;
printf " 3(x̄-Me)/σ) = %.2f", 3 * ($mean - $median)/$sd;
printf " (µ³/σ³) = %.2f\n", $u3/($sd*$sd*$sd);
##//
