# raku -c muelasvill.raku

sub main () {
    
    my $object = prompt;
    my $size = $object.Int;
    vowelCount(0, $size);

}

sub vowelCount($i, $size) {
    
    if $i == $size {
        return;
    }

    my @word = prompt().split("");
    my $lenghtOfWord = @word.elems;

    walkWord(0, @word, $lenghtOfWord, 0);
    vowelCount($i + 1, $size);

}

sub walkWord($nChar, @word, $lenghtOfWord, $cantOfvowel) {
    
    if $nChar >= $lenghtOfWord {
        print $cantOfvowel;
        print " ";
        return;
    }

    if @word[$nChar].contains("a") || @word[$nChar].contains("e") 
       || @word[$nChar].contains("i") || @word[$nChar].contains("o") 
       || @word[$nChar].contains("u") ||@word[$nChar].contains("y") {
        walkWord($nChar + 1, @word, $lenghtOfWord, $cantOfvowel + 1);
    } else {
        walkWord($nChar + 1, @word, $lenghtOfWord, $cantOfvowel);
    }

}

main()

# cat DATA.lst | rakudo muelasvill.raku
# 12 3 11 11 11 4 10 13 5 7 12 16 13 15 10 10
