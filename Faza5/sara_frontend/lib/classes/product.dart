class Proizvod {
  int id;
  String naziv;
  String opis;
  String putanja;
  double cena;
  String sezona;
  String tagovi;
  int godinaOd;
  int godinaDo;
  String pol;
  int popust;

  Proizvod({
    required this.cena,
    required this.godinaDo,
    required this.godinaOd,
    required this.id,
    required this.naziv,
    required this.opis,
    required this.putanja,
    required this.sezona,
    required this.tagovi,
    required this.pol,
    required this.popust,
  });

  factory Proizvod.fromJson(Map<String, dynamic> _json) {
    return Proizvod(
      cena: _json['Cena'],
      godinaDo: _json['godinaDo'],
      godinaOd: _json['godinaOd'],
      id: _json['ID'],
      naziv: _json['Naziv'],
      opis: _json['Opis'],
      putanja: _json['Putanja'],
      sezona: _json['Sezona'],
      tagovi: _json['Tagovi'],
      pol: _json['Pol'],
      popust: _json['Popust'],
    );
  }
  Map<String, dynamic> toJson() => {
        'ID': id,
        'godinaOd': godinaOd,
        'godinaDo': godinaDo,
        'Cena': cena,
        'Naziv': naziv,
        'Opis': opis,
        'Putanja': putanja,
        'Sezona': sezona,
        'Tagovi': tagovi,
        'Pol': pol,
        'Popust': popust,
      };
}
