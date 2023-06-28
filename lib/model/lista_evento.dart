import 'package:ifsp_aluno/model/evento.dart';

class ListaEvento {
  late String matricula;
  late List<Evento> eventos;

  ListaEvento({
    required this.matricula,
    required this.eventos,
  });

  ListaEvento.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return;
    matricula = json['key'];
    eventos = Evento.listFromJson(json['props']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['matricula'] = matricula;
    return data;
  }
}
