# raku -c muelasvill.raku

sub main () {
    
    my @information = prompt().split(" ");
    my $cantOfNumbers = @information[0];
    FahrenheitToCelsius(1, $cantOfNumbers, @information);

}

sub FahrenheitToCelsius($i, $cantOfnumbers, @information) {
    
    if $i > $cantOfnumbers {
        return;
    }

    my $Fahrenheit = @information[$i];
    print (($Fahrenheit - 32) * (5 / 9)).round();
    print " ";

    FahrenheitToCelsius($i + 1, $cantOfnumbers, @information);

}

main()

# cat DATA.lst | rakudo muelasvill.raku
# 224 173 270 39 157 314 252 208 281 104 242 233 244 77 101 119 118 95 206 310
# 143 291 14 267 229 15 230 98 163 179
