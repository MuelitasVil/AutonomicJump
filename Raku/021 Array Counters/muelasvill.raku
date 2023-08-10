# raku -c muelasvill.raku

sub main () {
    
    my @information = prompt().split(" ");
    my $cantOfNumbers = @information[0];
    my $setOfNumbers = @information[1];
    
    my @numbers = prompt().split(" ");
    my @counterNumbers[$setOfNumbers];
    
    ArrayCounters(0, $cantOfNumbers, @numbers, @counterNumbers);

}

sub printArray($i,@counterNumbers){
    
    if $i == @counterNumbers.elems { 
        return;
    }

    print @counterNumbers[$i];
    print " ";

    printArray($i + 1,@counterNumbers);

}

sub ArrayCounters($i, $cantOfnumbers, @information, @counterNumbers) {
    
    if $i == $cantOfnumbers {
        printArray(0,@counterNumbers);
        return;
    }

    my $index = @information[$i] - 1; 
    
    if (!@counterNumbers[$index]) {
        @counterNumbers[$index] = 1;
    } else {
        @counterNumbers[$index]++;
    }
    
    ArrayCounters($i + 1, $cantOfnumbers, @information, @counterNumbers);

}

main()

# cat DATA.lst | rakudo muelasvill.raku
# 18 17 20 28 26 9 17 18 20 22 24 20 28 20 26 25 25 22
