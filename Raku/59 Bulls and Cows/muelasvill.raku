# raku -c muelasvill.raku

sub main () {
    
  my ($number, $Cantguesses) = prompt.split(" ");
  $number = $number.Str().split("");
  my @guesses = prompt().split(" ");
  BullsandCows(0, $Cantguesses, @guesses, $number);

}

sub BullsandCows($i, $Cantguesses, @guesses, $number) {
    
  if $i == $Cantguesses {
      
    return;
  
  }

  my $guess = @guesses[$i].Str().split("");  
  my $correctPosition = CorrectPosition(1, $number, $guess, 0);
  my $correctNumber = 0;
 
  if CorrectNumber(1, 1, $guess[1], $number) {

    $correctNumber = $correctNumber + 1; 

  }

  if CorrectNumber(1, 2, $guess[2], $number) {

    $correctNumber = $correctNumber + 1; 

  }

  if CorrectNumber(1, 3, $guess[3], $number) {

    $correctNumber = $correctNumber + 1; 

  }

  if CorrectNumber(1, 4, $guess[4], $number) {

    $correctNumber = $correctNumber + 1; 

  }

  print $correctPosition;
  print "-";
  print $correctNumber;
  print " ";

  BullsandCows($i + 1, $Cantguesses, @guesses, $number);

}

sub CorrectPosition($i, $number, $guess, $cantGoodNumber) {

  if $i == 5 {
    
    return $cantGoodNumber;
  
  }

  if $number[$i] == $guess[$i] {
    
    return CorrectPosition($i + 1,$number, $guess, $cantGoodNumber + 1);
  
  } else {

    return CorrectPosition($i + 1,$number, $guess, $cantGoodNumber);

  }

}

sub CorrectNumber($i, $index, $digit, $number) {

  if $i == 5 {

    return False;

  }
  
  if $digit == $number[$i] and $index != $i {

    return True;  

  }

  return CorrectNumber($i + 1, $index, $digit, $number);

}

main()

# cat DATA.lst | rakudo muelasvill.raku
# 0-1 0-3 0-1 0-2 2-0 1-1 0-2 1-2 1-3 0-2 2-0 2-1 1-1 0-2 0-1
