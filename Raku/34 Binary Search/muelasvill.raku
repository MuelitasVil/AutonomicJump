# raku -c muelasvill.raku

sub main () {
    
    my $object = prompt;
    my $size = $object.Int;
    BinarySearch(0, $size);

}

sub BinarySearch($i, $size) {
    
    if $i == $size {
        return;
    }

    my ($A, $B, $C, $D) = prompt.split(" ");
    my $start = 0;
    my $end = 100;
    print GetX($A, $B, $C, $D, $start, $end);
    print " ";
    BinarySearch($i + 1, $size);

}

sub GetX($A, $B, $C, $D, $start, $end) {

    my $half = ($start + $end) / 2;
    my $result =  GetResult($A, $B, $C, $D, $half);

    if $result >= 0 && $result <= 0.0000001 {
      return $half;
    }

    if $result < 0 {
        return GetX($A, $B, $C, $D, $half, $end);
    }
    
    if $result > 0 {
        return GetX($A, $B, $C, $D, $start, $half);
    }
    
}

sub GetResult($A, $B, $C, $D, $half) {
  
    return (($A * $half) + ($B * sqrt($half * $half * $half))) 
    - ($C * exp((-1 * $half) / 50)) - $D;

}

main()

# cat DATA.lst | rakudo muelasvill.raku
# 12 3 11 11 11 4 10 13 5 7 12 16 13 15 10 10
