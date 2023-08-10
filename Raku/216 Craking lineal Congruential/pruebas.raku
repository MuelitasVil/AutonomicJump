
sub main () {
    
    my $object = prompt;
    my $size = $object.Int;
    my $mod = 2**64;
    #say 9 % -2 
    #say $mod;
    #say getModularInverse(3,26);
    CrakingLinealCongruential(0,$size,$mod);
}

sub CrakingLinealCongruential($i, $size, $mod) {
    
    if $i == $size {
        return;
    }

    my ($number1, $number2, $number3) = prompt.split(" ");
    getNumber($number1,$number2,$number3,$mod);
    CrakingLinealCongruential($i + 1, $size, $mod);

}

sub getNumber($number1,$number2,$number3,$mod) {
    
  my $multiplier = getMultipler($number1,$number2,$number3,$mod);
  my $increment = getIncrement($number1, $number2, $mod, $multiplier);
  my $newNumber = (($number3 * $multiplier) + $increment) % $mod;
  #say "numero 1 : ";
  #say $number1;
  #say "numero 2 : ";
  #say $number2;
  #say "numero 3 : ";
  #say $number3;
  #say "increment : ";
  #say $increment;
  #say "multiplier : ";
  #say $multiplier;
  #say "new numver : ";
  #say $newNumber;
  #say "newNUmber : ";
  print $newNumber;
  print " ";
}

sub getMultipler($number1,$number2,$number3,$mod) {
  my $modularInverse = getModularInverse($number2 - $number1, $mod);
  #say "Modular inverse ";
  #say $modularInverse;
  my $multiplier = (($number3 - $number2) * $modularInverse) % $mod;
  return $multiplier;

}

sub getIncrement($number1, $number2, $mod, $multiplier) {

    my $increment = ($number2 - ($number1 * $multiplier)) % $mod;
    return $increment;
}

sub getModularInverse($number, $mod) {
    
    my $g0 = $mod;
    my $g1 = $number; 
    my $u0 = 1;
    my $u1 = 0;
    my $v0 = 0;
    my $v1 = 1;
    my $invMod =  ModularInverse($g0, $g1, $u0, $u1, $v0, $v1, $mod, $number);

    #if ((($number * $invMod) % $mod) == 1) {
    #    print $invMod;
    #    print " true ";
    #}
    #else {
    #    print $invMod;
    #    print " ";
    #}

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

    #$i = $i + 1;

    #say "-------------------";
    #say $i;
    #say "g-1";
    #say $g0;
    #say "g";
    #say $g1;
    #say "u-1";
    #say $u0;
    #say "u";
    #say $u1;
    #say "v-1";
    #say $v0;
    #say "v";
    #say $v1;

    if ($g1 == 0) {
        
        if isModularInverse($v0 * -1,$num,$mod) {
            return $v0 * -1;
        }

        if isModularInverse($v0 + $mod,$num,$mod) {
            return $v0 + $mod;
        }

        return $v0;
    }

    return ModularInverse($g0, $g1, $u0, $u1, $v0, $v1, $mod, $num);


}

main();

# cat DATA.lst | rakudo muelasvill.raku
# 5444181524487888951 13847485880704710720 16882028563105266788 
# 9627730222986768893 16329605028109903872 10780608620680725911
# 15012680324841620975 16101275382338809044 17254913153268073693
# 756967198334769023 1557499840294561530 3007583930511712915
# 7233060293728025809 933906294762560053 12365670123523646935
# 12682222068722681528 11469859351497761497 8814240644432881799
# 15591166052786388485 9361985816072680463 16184186095633552488
# 2767313894143793532 13775178771396251583 15146854135469335994
# 17401537210274475870 11224699739341681919 11867007776205403601
# 7391055575795305262 2807547787717700689 7909019028645407765 6973529088483902746 
