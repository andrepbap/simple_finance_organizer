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
      {required String fromEntity,
      Map<String, dynamic>? withQuery,
      String? orderingBy}) async {
    var collection = db.collection("user").doc(userId).collection(fromEntity);

    // if (withQuery != null) {
    //   for (var element in withQuery.entries) {
    //     collection.where(element.key, isEqualTo: element.value);
    //   }
    // }

    QuerySnapshot<Map<String, dynamic>> result;

    if (orderingBy != null) {
      result = withQuery != null
          ? await collection
              .where(withQuery.entries.first.key,
                  isEqualTo: withQuery.entries.first.value)
              .orderBy(orderingBy, descending: true)
              .get()
          : await collection.orderBy(orderingBy, descending: true).get();
    } else {
      result = withQuery != null
          ? await collection
              .where(withQuery.entries.first.key,
                  isEqualTo: withQuery.entries.first.value)
              .get()
          : await collection.get();
    }

    List<Map<String, dynamic>> mapArray = [];

    for (var docSnapshot in result.docs) {
      var map = docSnapshot.data();

      final id = <String, String>{'id': docSnapshot.id};
      map.addEntries(id.entries);

      mapArray.add(map);
    }

    return mapArray;
  }

  @override
  void create(
      {required Map<String, dynamic> object,
      required String onEntity,
      String? withKey}) async {
    var targetCollection =
        db.collection("user").doc(userId).collection(onEntity);

    if (withKey != null) {
      await targetCollection.doc(withKey).set(object);
      return;
    }

    await targetCollection.add(object);
  }

  @override
  void update(
      {required Map<String, dynamic> object,
      required String inEntity,
      required String where}) async {
    await db
        .collection("user")
        .doc(userId)
        .collection(inEntity)
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
