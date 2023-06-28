class Evento {
  late String date;
  late String title;
  late String type;
  late String desc;

  Evento({
    required this.date,
    required this.title,
    required this.type,
    required this.desc,
  });

  Evento.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return;

    date = json['date'];
    title = json['title'];
    type = json['type'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['date'] = date;
    data['title'] = title;
    data['type'] = type;
    data['desc'] = desc;

    return data;
  }

  static List<Evento> listFromJson(Map<String, dynamic> json) {
    List<Evento> list = [];

    json.isEmpty
        ? null
        : json.forEach((key, value) {
            if (key != 'updated' && key != 'created') {
              list.add(Evento.fromJson(value));
            }
          });

    return list;
  }
}
