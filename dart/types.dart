abstract class MalType {}

class MalList implements MalType {
  final List<MalType> _types;
  const MalList(this._types);
}

abstract class MalAtom extends MalType {}

class MalInt implements MalAtom {
  final int _value;
  const MalInt(this._value);
}

class MalSym implements MalAtom {
  final String _value;
  const MalSym(this._value);
}