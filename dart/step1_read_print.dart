import 'dart:convert';
import 'dart:io';

READ(x) => x;
EVAL(x) => x;
PRINT(x) => x;

rep(x) => PRINT(EVAL(READ(x)));

prompt() => stdout.write('user> ');

main() {
  prompt();
  var input = stdin.transform(UTF8.decoder).transform(new LineSplitter());
  input.listen((line) {
    print(rep(line));
    prompt();
  });
}
