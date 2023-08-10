[indent=2]

init
  line:string = stdin.read_line();
  solution(line);

def solution (data:string)
  var split = data.split(" ");
  a:int = int.parse(split[0]);
  b:int = int.parse(split[1]);
  print "%d", a + b;
