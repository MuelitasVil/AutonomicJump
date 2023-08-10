# raku -c muelasvill.raku


sub main () {
    
  my $object = prompt;
  my $size = $object.Int;
  SquareRoot(0, $size);

}

sub SquareRoot($i, $size) {
    
  if $i == $size {
      return;
  }  

  my ($x, $steps) = prompt.split(" ");
  my $r = 1;

  print getSquareRoot(0, $steps, $r, $x);
  print " ";
    
  SquareRoot($i + 1, $size);

}

sub getSquareRoot($j, $steps, $r is rw, $x) {

  if $j == $steps { 

    return $r

  }

  $r = ($r + ($x / $r)) / 2;

  return getSquareRoot($j + 1, $steps, $r, $x);

}

main()

# cat DATA.lst | rakudo muelasvill.raku
# 24.758836806279895 1328.249812 20.71249108799062 90.5 923.8999609971422
# 3.3166247903554 8.005147977880979 23.68543856465402 61.09104580478963
# 9.746794344808965 36.58136621510975 144.498258
