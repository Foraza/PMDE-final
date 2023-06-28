import 'package:ifsp_aluno/model/lista_evento.dart';
import 'package:ifsp_aluno/repositories/event_repo.dart';
import 'package:ifsp_aluno/viewmodel/general_viewmodel.dart';

class EventViewModel extends GeneralViewModel<ListaEvento, EventRepo> {
  late final String _matricula;
  EventViewModel({required super.repo});

  String get matricula => _matricula;

  setMatricula(String matricula) {
    repo.key = matricula;
    _matricula = matricula;

    fetchData();
  }

  Future<bool> addEvent() async {
    setLoadingState(true);
    bool confirm = await repo.addEvent(model.eventos);

    if (confirm) {
      // Atualiza os dados e muda o loadingState
      await fetchData();
    }

    return confirm;
  }
}
