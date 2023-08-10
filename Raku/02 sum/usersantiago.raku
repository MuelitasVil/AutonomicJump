# rakudo -c usersantiago.raku

sub main () {
  my $numCases = get().Int;
  my @values = $*IN.get.split(" ").sum;
  say @values.Str;
}

main()

# cat DATA.lst | rakudo usersantiago.raku
# 22994
