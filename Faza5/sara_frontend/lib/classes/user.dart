class User {
  int id;
  String username;
  String password;
  String ime;
  String email;
  String pol;
  int potroseno;
  String datum;
  String tip;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.ime,
    required this.datum,
    required this.email,
    required this.pol,
    required this.potroseno,
    required this.tip,
  });

  factory User.fromJson(Map<String, dynamic> _json) {
    return User(
      id: _json['ID'],
      username: _json['Username'],
      password: _json['Password'],
      ime: _json['ImeIPrezime'],
      datum: _json['Datum'],
      email: _json['Email'],
      pol: _json['Pol'],
      potroseno: _json['Potroseno'],
      tip: _json['Tip'],
    );
  }

  Map<String, dynamic> toJson() => {
        'ID': id,
        'Username': username,
        'Password': password,
        'ImeIPrezime': ime,
        'Datum': datum,
        'Email': email,
        'Pol': pol,
        'Potroseno': potroseno,
        'Tip': tip,
      };
}
