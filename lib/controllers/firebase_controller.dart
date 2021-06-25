import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fltr_firebase/models/user_data.dart';
import 'package:fltr_firebase/services/firebase_storage_service.dart';
import 'package:fltr_firebase/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseController extends ChangeNotifier {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final imageController = TextEditingController();

  static final storage = FirebaseStorage.instance.ref("users");
  static String? imageUrl = ImageStorage.imageUrl;

  var selectedImagePath = "";
  var selectedImageSize = "";

  pickImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath = pickedFile.path;
      selectedImageSize = ((File(selectedImagePath)).lengthSync() / 1024 / 1024)
          .toStringAsFixed(2) +
          "MB";
    } else {
      print("<=========No Image Selected=========>");
    }
    notifyListeners();
  }

  void uploadImage({required String path}) async {
    print(">>>>>>>>>>>>>Path:"+path);
    await ImageStorage.uploadImage(path);
    await addData();
    notifyListeners();
  }

  addData() async {
    UserData userData = UserData(
        name: nameController.text,
        age: ageController.text,
        image: imageUrl);
    await FirestoreService.addData(userData);
    fieldReset();
  }

  Stream<QuerySnapshot> getData() {
    return FirestoreService.fireStore
        .orderBy("name", descending: true)
        .snapshots();
  }

  editData({required String name, required String age}) {
    nameController.text = name;
    ageController.text = age;
  }

  updateData(String id) async {
    UserData userData =
    UserData(name: nameController.text,
        age: ageController.text,
        image: imageUrl);
    await FirestoreService.updateData(userData: userData, id: id);
    fieldReset();
  }

  deleteData(String id) async {
    print("delete id: " + id);
    await FirestoreService.deleteData(id: id);
  }

  fieldReset() {
    nameController.clear();
    ageController.clear();
    selectedImagePath = "";
    selectedImageSize = "";
  }
}
