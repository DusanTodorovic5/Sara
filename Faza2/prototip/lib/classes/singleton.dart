// AUTHOR : Dušan Todorović

class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();

  String _mod = "N";

  String get mod{
    return _mod;
  }

  set mod(String _mod){
    this._mod = _mod;
  }
}
