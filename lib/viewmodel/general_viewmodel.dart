// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:ifsp_aluno/repositories/general_repo.dart';

class GeneralViewModel<TModel, TRepository extends GeneralRepo> extends ChangeNotifier {
  final TRepository repo;
  bool _loadingState = true;
  late TModel _model;

  GeneralViewModel({
    required this.repo,
  }) {
    fetchData();
  }

  bool get isLoading => _loadingState;

  void setLoadingState(bool state) async {
    _loadingState = state;
    notifyListeners();
  }

  TModel get model => _model;

  Future<void> fetchData() async {
    try {
      setLoadingState(true);
      _model = await repo.fetchData();
      setLoadingState(false);
    } catch (e) {
      debugPrint('Erro no fetchData: $e');
    }
  }
}
