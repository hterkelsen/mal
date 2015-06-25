library reader;

import 'types.dart';

class Reader {
  List<String> _tokens;
  int _position;
  Reader(this._tokens) : _position = 0;
  String next() => _tokens[_position++];
  String peek() => _tokens[_position];
}

read_str(String s) {
  var tokens = tokenizer(s);
  var reader = new Reader(tokens);
  read_form(reader);
}

MalType read_form(Reader r) {
  var tok = r.peek();
  if (tok == '(') {
    return read_list(r);
  } else {
    return read_atom(r);
  }
}

MalList read_list(Reader r) {
  // consume leading '('
  r.next();
  var types = <MalType>[];
  while (r.peek() != ')') {
    types.add(read_form(r));
  }
  // consume closing ')'
  r.next();
  return new MalList(types);
} 

MalAtom read_atom(Reader r) {
  var tok = r.next();
  var parsedInt = int.parse(tok, onError: (_) => null);
  if (parsedInt != null) {
    return new MalInt(parsedInt);
  } else {
    return new MalSym(tok);
  }
}

List<String> tokenizer(String s) {
  var regex = new RegExp("""
[\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"|;.*|[^\s\[\]{}('"`,;)]*)
""");
  return regex.allMatches(s).toList();
}