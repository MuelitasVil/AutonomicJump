# raku -c muelasvill.raku

sub main () {
    
  my $object = prompt;
  my $cantOfTimes = $object.Int;
  my @frequencies = prompt().split(" ");
  InstrumentTuner(0, $cantOfTimes, @frequencies); 

}


sub InstrumentTuner($i, $cantOfnumbers, @frequencies) {
    
    if $i == $cantOfnumbers {
      return;
    }

    getNoteName(@frequencies[$i]);

    InstrumentTuner($i + 1, $cantOfnumbers, @frequencies);

}

sub getNoteName($frequency) {
  
  my %DictionaryOfNotes = (
    1  => "C",  2  => "C#", 3  => "D", 4  => "D#",
    5  => "E",  6  => "F",  7  => "F#", 8  => "G",
    9  => "G#", 10 => "A",  11 => "A#", 0  => "B",
  );

  my $distance = round(log(($frequency / 16.352),2) * 12)  + 1;
  my $note = ($distance % 12);
  my $numberOctabe = floor(($distance / 13)).Str;
  
  print %DictionaryOfNotes{$note} ~ $numberOctabe;
  print " "; 

}

main()

# cat DATA.lst | rakudo muelasvill.raku
# A5 G1 G5 F1 C#1 A3 A#2 A#5 D3 F2 F3 F#4 D2 F#3 B1 B4 F4 F#2 B3 A2
