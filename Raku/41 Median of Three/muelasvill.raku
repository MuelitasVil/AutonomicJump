# raku -c muelasvill.raku

sub main () {
    
  my $object = prompt;
  my $size = $object.Int;
  medianOfThree(0, $size);

}

sub medianOfThree($i, $size) {
    
  if $i == $size { 
    return;
  }

  my ($number1, $number2, $number3) = prompt.split(" ");
  
  if median($number1,$number2,$number3) {
    print $number1;
    print " ";
  }

  if median($number2,$number1,$number3) {
    print $number2;
    print " ";
  }

  if median($number3,$number1,$number2) {
    print $number3;
    print " ";
  }

  medianOfThree($i + 1, $size);

}

sub median($number1,$number2,$number3) {
    
    if ($number1 > $number2 && $number1 < $number3) {
        
        return True;
    
    }

    if ($number1 < $number2 && $number1 > $number3) {

        return True;

    }

    return False; 

}

main()

# cat DATA.lst | rakudo muelasvill.raku
# 597 170 7 1474 12 896 119 17 44 10 17 211 84 40 865 103 39 11 54 46 10 200 507 286 
