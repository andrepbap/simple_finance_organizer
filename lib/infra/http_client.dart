abstract class HttpClient {
  Future<Map<String, dynamic>> get({required String from, String where});

  Future<List<Map<String, dynamic>>> getAll(
      {required String fromEntity,
      Map<String, dynamic>? withQuery,
      String? orderingBy});

  void create(
      {required Map<String, dynamic> object,
      required String onEntity,
      String? withKey});

  void update(
      {required Map<String, dynamic> object,
      required String inEntity,
      required String where});

  void delete({required String from, required String where});
}
