import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ImageStorage {
  static final storage = FirebaseStorage.instance.ref("users");
  static String? imageUrl;

  static uploadImage(String filePath) async {
    File file = File(filePath);
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    try {
      var dir = storage.child(currentTime.toString());
      await dir.putFile(file);
      print("=====Success=====");
      imageUrl =
          (await storage.child(currentTime.toString()).getDownloadURL()).toString();
      print("========URL========" + imageUrl!);
    } on FirebaseException catch (error) {
      print("Error: " + error.toString());
    }
  }
}
