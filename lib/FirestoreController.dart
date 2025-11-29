import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreController {
  final CollectionReference users = FirebaseFirestore.instance.collection(
    'users',
  );

  // Stream realtime
  Stream<QuerySnapshot> streamUsers() {
    return users.orderBy('createdAt', descending: true).snapshots();
  }

  // CREATE user
  Future<void> createUsers(String name, String description) {
    return users.add({
      "name": name,
      "description": description,
      "createdAt": DateTime.now().toIso8601String(),
    });
  }

  // UPDATE user
  Future<void> updateUsers(String docId, String name, String description) {
    return users.doc(docId).update({"name": name, "description": description});
  }

  // DELETE user
  Future<void> deleteUsers(String docId) {
    return users.doc(docId).delete();
  }
}