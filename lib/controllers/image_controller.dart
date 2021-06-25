import 'dart:io';

import 'package:fltr_firebase/services/firebase_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends ChangeNotifier {
  var selectedImagePath = "";
  var selectedImageSize = "";

  // var croppedImagePath = "";
  // var croppedImageSize = "";

  // var compressedImagePath = "";
  // var compressedImageSize = "";

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath = pickedFile.path;
      selectedImageSize = ((File(selectedImagePath)).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2) +
          "MB";
      print("=========" + "path: " + selectedImagePath + "=========");
      print("=========" + "size: " + selectedImageSize + "=========");

      //Crop Image
      /*final croppedImageFile = await ImageCropper.cropImage(
          sourcePath: selectedImagePath,
          maxHeight: 512,
          maxWidth: 512,
          compressFormat: ImageCompressFormat.jpg
      );*/
      /*croppedImagePath = croppedImageFile!.path;
      croppedImageSize =
          ((File(croppedImagePath)).lengthSync() / 1024 / 1024).toStringAsFixed(
              2) + "MB";

      //Compress Image
      final dir = Directory.systemTemp;
      final targetPath = dir.absolute.path + "/temp.jpg";
      var compressedFile = await FlutterImageCompress.compressAndGetFile(
          croppedImagePath, targetPath, quality: 90);
      compressedImagePath = compressedFile!.path;
      compressedImageSize = ((File(compressedImagePath)).lengthSync() / 1024 / 1024).toStringAsFixed(
          2) + "MB";*/
    } else {
      print("<=========No Image Selected=========>");
    }
    notifyListeners();
  }

  void uploadImage({required String path}) {
    ImageStorage.uploadImage(path);
    selectedImagePath = "";
    selectedImageSize = "";
    notifyListeners();
  }
}
