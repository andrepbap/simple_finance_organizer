import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_finance_organizer/infra/http_client.dart';

class HttpClientImpl implements HttpClient {
  final db = FirebaseFirestore.instance;
  final userId = "andrepbap@gmail.com";

  @override
  Future<Map<String, dynamic>> get(
      {required String from, String? where}) async {
    var document = await db
        .collection("user")
        .doc(userId)
        .collection(from)
        .doc(where)
        .get();
    return document.data() as Map<String, dynamic>;
  }

  @override
  Future<List<Map<String, dynamic>>> getAll({required String from}) async {
    var query = await db.collection("user").doc(userId).collection(from).get();

    List<Map<String, dynamic>> mapArray = [];

    for (var docSnapshot in query.docs) {
      mapArray.add(docSnapshot.data());
    }

    return mapArray;
  }

  @override
  void post(
      {required Map<String, dynamic> object,
      required String to,
      String? where}) async {
    await db.collection("user").doc(userId).collection(to).add(object);
  }
}
