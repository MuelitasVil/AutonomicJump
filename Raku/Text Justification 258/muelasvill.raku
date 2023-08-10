# raku -c muelasvill.raku

sub main () {
  
  my $text = slurp "DATA.lst";
  my @info = $text.split("\n");
  
  my $cantOfchars = @info[0].Int;
  my $words = "";
  my @words = getArrayOfWords(1, @info, $words).split(" ");
  my $i = 1;
  getLines($i, @words, $cantOfchars);

}

sub getArrayOfWords($i, @info, $words is rw) {
    
  if $i == @info.elems - 1 {
      return $words;
  } 

  $words = $words ~ " " ~ @info[$i];
  getArrayOfWords($i + 1, @info, $words);

}

sub getLines($i is rw, @words, $cantOfchars) {
  
  if VerifyWords($i, @words, $cantOfchars) {
    my $cantOfWords = @words - $i; 
    printCase1($i,0,$cantOfWords,@words);
    return;
  }

  $i = $i + walkWord($i,@words,$cantOfchars);

  getLines($i, @words, $cantOfchars);

}

sub walkWord($i is rw,@words,$cantOfchars) {

  my $lenghtOfWords = CharsInWords($i,0,@words,$cantOfchars,[]);
  my $info = accommodateWords(1 ,$lenghtOfWords,$cantOfchars); 
  
  my $j = $info[0];
  my $blanks = $info[1];
  my $case = $info[2];

  my $cantOfWords = $lenghtOfWords[0 .. ($lenghtOfWords.elems - $j)].elems;

  if $case == 1 {
  
    printCase1($i,0,$cantOfWords - 1,@words);
  
  }

  if $case == 2 {

    printCase2($i,$blanks, @words);

  }

  if $case == 3 {

    printCase3($i,$blanks,@words);

  }
  
  return $cantOfWords - 1;
  

}

sub printCase1($i,$nword,$cantOfWords,@words) {

  if $nword == $cantOfWords {
    print "\n";
    return;
  }
  
  print @words[$i] ~ " ";
  
  printCase1($i + 1,$nword + 1,$cantOfWords,@words);  

}

sub printCase2($i,$blanks, @words) {

  say @words[$i] ~ (" " x $blanks) ~ @words[$i + 1];  

}

sub printCase3($i,$blanks,@words) {

  my $blanksSpaces = $blanks / 2;

  if $blanks % 2 == 0 {
    say @words[$i] ~ (" " x $blanksSpaces) ~ @words[$i + 1] 
    ~ (" " x $blanksSpaces) ~ @words[$i + 2];
  }

  if $blanks % 2 != 0 {
    say @words[$i] ~ (" " x $blanksSpaces.round) ~ @words[$i + 1]
     ~ (" " x $blanksSpaces.floor) ~ @words[$i + 2];
  }
    

}

sub accommodateWords($j,$lenghtOfWords,$cantOfchars) {
  
  my $voidSpaces = $cantOfchars - $lenghtOfWords[$lenghtOfWords.elems - $j];
  my $cantOfWords = $lenghtOfWords[0 .. ($lenghtOfWords.elems - $j)].elems;

  if $voidSpaces < $cantOfWords - 2 {

    return accommodateWords($j + 1,$lenghtOfWords,$cantOfchars);

  } 

  if $voidSpaces == $cantOfWords - 2 { 

    return [$j, 1, 1];

  }

  if $cantOfWords - 1 == 2 { 

    return [$j, $voidSpaces, 2];

  }

  if $cantOfWords - 1 == 3 { 

    return [$j, $voidSpaces, 3];

  }

  return [$j, VerifyBlanks(2, $voidSpaces, $cantOfWords), 4];
   
}

sub VerifyBlanks($i, $voidSpaces, $cantOfWords) {

if $i > $voidSpaces {
  
  return 0;

}

if $voidSpaces div $i == $cantOfWords - 1 and $voidSpaces mod $i <= 1 {
  
  return $i;
 
}

VerifyBlanks($i + 1, $voidSpaces, $cantOfWords);

}

sub CharsInWords($i,$sum,@words,$cantOfchars,$arrayLeghtWords) {
 
  if $sum > $cantOfchars || $i == @words.elems - 1 {
    return $arrayLeghtWords;
  }

  $arrayLeghtWords.push($sum);

  CharsInWords(
  $i + 1,$sum + length(@words[$i]),@words,$cantOfchars,$arrayLeghtWords
  );

}

sub VerifyWords($i, @words,$cantOfchars) {
  

  if CharsInText($i, 0, @words, $cantOfchars) <= $cantOfchars { 
    
    return True;
  
  } else {

    return False;

  }

}

sub CharsInText($i,$sum,@words,$cantOfchars) {
 
  if $sum > $cantOfchars || $i == @words.elems - 1 {
    return $sum;
  }

  CharsInText($i + 1, $sum + length(@words[$i]), @words, $cantOfchars)

}

sub length($string) {

  return $string.split("").elems - 2;
 
 }

main();

# rakudo muelasvill.raku
# "When       Mrs.
# Turner       has
# brought  in  the
# tray I will make
# it clear to you.
# Now," he said as
# he        turned
# hungrily  on the
# simple fare that
# our landlady had
# provided,     "I
# must  discuss it
# while I eat, for
# time.    It   is
# nearly five now. 
# scene of action.
# Miss  Irene,  or
# Madame,  rather,
# returns from her 
# drive  at seven.
# Briony  Lodge to
# meet her."
