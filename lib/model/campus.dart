class Campus {
  late String sigla;

  late String nome;

  late String siteUrl;

  late String avaUrl;

  Campus(
      {required this.nome,
      required this.sigla,
      required this.siteUrl,
      required this.avaUrl});

  @override
  String toString() {
    return 'Campus[sigla=$sigla, nome=$nome, siteUrl=$siteUrl, avaUrl=$avaUrl, ]';
  }

  Campus.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return;
    sigla = json['sigla'];
    nome = json['nome'];
    siteUrl = json['siteUrl'];
    avaUrl = json['avaUrl'];
  }

  Map<String, dynamic> toJson() {
    return {'sigla': sigla, 'nome': nome, 'siteUrl': siteUrl, 'avaUrl': avaUrl};
  }

  static List<Campus> listFromJson(List<dynamic> json) {
    return json.isEmpty
        ? <Campus>[]
        : json.map((value) => Campus.fromJson(value)).toList();
  }

  static Map<String, Campus> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = <String, Campus>{};
    if (json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = Campus.fromJson(value));
    }
    return map;
  }
}
