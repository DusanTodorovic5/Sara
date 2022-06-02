class Zeli {
  int IdKorisnika;
  int IdProizvoda;
  String Obavesti;
  String naziv;

  Zeli({
    required this.IdKorisnika,
    required this.IdProizvoda,
    required this.Obavesti,
    required this.naziv,
  });

  factory Zeli.fromJson(Map<String, dynamic> _json) {
    return Zeli(
      IdKorisnika: _json['IdKorisnika'],
      IdProizvoda: _json['IdProizvoda'],
      Obavesti: _json['Obavesti'],
      naziv: _json['naziv'],
    );
  }

  Map<String, dynamic> toJson() => {
        'IdKorisnika': IdKorisnika,
        'IdProizvoda': IdProizvoda,
        'Obavesti': Obavesti,
        'naziv': naziv,
      };
}
