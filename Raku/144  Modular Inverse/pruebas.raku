
sub main () {
    
  my $object = prompt;
  my $size = $object.Int;
  Getx(0,$size);

}

sub Getx($i, $size) {
    
    if $i == $size {
        return;
    }

    my ($mod, $A, $B) = prompt.split(" ");
    getNumber($mod,$A,$B);
    Getx($i + 1, $size);

}

sub getNumber($mod,$A,$B) {

    my $modularInverse = getModularInverse($A, $mod);

    if isModularInverse($modularInverse, $A, $mod) {
        print (($B * -1) * $modularInverse) % $mod;
        print " ";
    } else {
        print -1;
        print " ";
    }
    

}

sub getModularInverse($number, $mod) {
    
    my $g0 = $mod;
    my $g1 = $number; 
    my $u0 = 1;
    my $u1 = 0;
    my $v0 = 0;
    my $v1 = 1;
    my $invMod =  ModularInverse($g0, $g1, $u0, $u1, $v0, $v1, $mod, $number);
    return $invMod;

}

sub isModularInverse($modularInverse, $num, $mod){
    
    if (($modularInverse * $num) % $mod) == 1 {
        return True;
    } else {
        return False;
    }


}

sub ModularInverse($g0 is rw, $g1 is rw, $u0 is rw, $u1 is rw, $v0 is rw, 
    $v1 is rw, $mod, $num) {

    my $temp_g = $g1;
    my $temp_u = $u1;
    my $temp_v = $v1;

    my $y = ($g0 / $g1).floor;

    $g1 = ($g0 - ($y * $g1));
    $u1 = ($u0 - ($y * $u1));
    $v1 = ($v0 - ($y * $v1));

    $g0 = $temp_g;
    $u0 = $temp_u;
    $v0 = $temp_v;

    if ($g1 == 0) {
        
        if isModularInverse($v0 + $mod,$num,$mod) {
            return $v0 + $mod;
        }

        if isModularInverse($v0 * -1,$num,$mod) {
            return $v0 * -1;
        }

        return $v0;
    }

    return ModularInverse($g0, $g1, $u0, $u1, $v0, $v1, $mod, $num);

}

main();

# cat DATA.lst | rakudo muelasvill.raku
# 530949193 -1 -1 2060 -1 1878 817114 -1 -1 4871205 -1 42113402 626415 357871
# 252836 32744 -1 389009 -1 193755 353103912 491565271 4130014
