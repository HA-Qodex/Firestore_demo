import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fltr_firebase/models/user_data.dart';

class FirestoreService {
  static final fireStore = FirebaseFirestore.instance.collection("users");


  /*static addData(Map<String, dynamic> data) async {
    await fireStore
        .add(data)
        .then((value) => print("Success: " + value.id))
        .onError((error, stackTrace) => print("Failed " + error.toString()));
  }*/

  static addData(UserData userData) async {
    await fireStore
        .add(userData.toJson())
        .then((value) => print("Success: " + value.id))
        .onError((error, stackTrace) => print("Failed " + error.toString()));
  }

  /*static updateData(
      {required Map<String, dynamic> data, required String id}) async {
    await fireStore
        .doc(id)
        .update(data)
        .then((value) => print("Success: "))
        .onError((error, stackTrace) => print("Failed " + error.toString()));
  }*/


  static updateData(
      {required UserData userData, required String id}) async {
    await fireStore
        .doc(id)
        .update(userData.toJson())
        .then((value) => print("Success: "))
        .onError((error, stackTrace) => print("Failed " + error.toString()));
  }

  static deleteData({required String id}) async {
    await fireStore
        .doc(id)
        .delete()
        .then((value) => print("Deleted successfully"))
        .onError(
            (error, stackTrace) => print("Deleting failed" + error.toString()));
  }
}
