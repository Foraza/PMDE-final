abstract class GeneralRepo<T> {
  static String? matricula;
  Future<T> fetchData();
}
