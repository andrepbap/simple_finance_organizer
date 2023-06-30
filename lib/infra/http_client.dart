abstract class HttpClient {
  Future<Map<String, dynamic>> get({required String from, String where});

  Future<List<Map<String, dynamic>>> getAll(
      {required String from, String? orderBy});

  void post(
      {required Map<String, dynamic> object,
      required String toEntity,
      String? withKey});

  void put(
      {required Map<String, dynamic> object,
      required String to,
      required String where});

  void delete({required String from, required String where});
}
