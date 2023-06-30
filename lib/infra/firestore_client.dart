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
  Future<List<Map<String, dynamic>>> getAll(
      {required String from, String? orderBy}) async {
    var collection = db.collection("user").doc(userId).collection(from);

    QuerySnapshot<Map<String, dynamic>> query;

    if (orderBy != null) {
      query = await collection.orderBy(orderBy, descending: true).get();
    } else {
      query = await collection.get();
    }

    List<Map<String, dynamic>> mapArray = [];

    for (var docSnapshot in query.docs) {
      var map = docSnapshot.data();

      final id = <String, String>{'id': docSnapshot.id};
      map.addEntries(id.entries);

      mapArray.add(map);
    }

    return mapArray;
  }

  @override
  void post(
      {required Map<String, dynamic> object,
      required String toEntity,
      String? withKey}) async {
    var targetCollection =
        db.collection("user").doc(userId).collection(toEntity);

    if (withKey != null) {
      await targetCollection.doc(withKey).set(object);
      return;
    }

    await targetCollection.add(object);
  }

  @override
  void put(
      {required Map<String, dynamic> object,
      required String to,
      required String where}) async {
    await db
        .collection("user")
        .doc(userId)
        .collection(to)
        .doc(where)
        .set(object);
  }

  @override
  void delete({required String from, required String where}) async {
    await db
        .collection("user")
        .doc(userId)
        .collection(from)
        .doc(where)
        .delete();
  }
}
