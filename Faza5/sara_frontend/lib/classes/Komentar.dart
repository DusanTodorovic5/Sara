class Komentar {
  int ID;
  String Textt;
  String Datum;
  int IDKorisnik;
  int IDProizvod;
  String username;

  Komentar({
    required this.ID,
    required this.Textt,
    required this.Datum,
    required this.IDKorisnik,
    required this.IDProizvod,
    required this.username,
  });

  factory Komentar.fromJson(Map<String, dynamic> _json) {
    return Komentar(
      ID: _json['ID'],
      Textt: _json['Text'],
      Datum: _json['Datum'],
      IDKorisnik: _json['IDKorisnik'],
      IDProizvod: _json['IDProizvod'],
      username: _json['username'],
    );
  }

  Map<String, dynamic> toJson() => {
        'ID': ID,
        'Text': Textt,
        'Datum': Datum,
        'IDKorisnik': IDKorisnik,
        'IDProizvod': IDProizvod,
        'username': username,
      };
}
