import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ifsp_aluno/model/evento.dart';
import 'package:ifsp_aluno/model/lista_evento.dart';
import 'package:ifsp_aluno/repositories/general_repo.dart';

class EventRepo extends GeneralRepo<ListaEvento> {
  String? key;

  @override
  Future<ListaEvento> fetchData() async {
    Dio dio = Dio();

    var response = await dio.get('https://fake-ifspaluno.cyclic.app/events/${GeneralRepo.matricula}');

    Map<String, dynamic> map = response.data;

    return ListaEvento.fromJson(map);
  }

  Future<bool> addEvent(List<Evento> events) async {
    Dio dio = Dio();

    var response =
        await dio.post('https://fake-ifspaluno.cyclic.app/events/${GeneralRepo.matricula}', data: json.encode(events));

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
