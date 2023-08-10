# raku -c muelasvill.raku


sub main () {
    
    my $object = prompt;
    my $size = $object.Int;
    minimumOfTwo(0, $size);

}

sub minimumOfTwo($i, $size) {
    if $i == $size {
        return;
    }

    my ($number1, $number2) = prompt.split(" ");

    if ($number1 < $number2) {
        print $number1;
        print " ";
    } else {
        print $number2;
        print " ";
    }
    
    minimumOfTwo($i + 1, $size);
}

main()

# cat DATA.lst | rakudo muelasvill.raku
# -7409981 -1615451 3286068 1013477 3453522 -3225183 -6968786 -8878769 -9467406
# -7249823 -1242494 936842 386232 -6966018 -9874952 -6450009 -4104162 -5548364
# -3376945 -5421497 -1792898 -7766262 -4963069 -6618086 3003532
