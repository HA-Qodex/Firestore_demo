import 'dart:io';

import 'package:fltr_firebase/controllers/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImagePickerPage extends StatelessWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageController = Provider.of<ImageController>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
          ),
          Consumer<ImageController>(
            builder: (context, controller, child) {
              return Container(
                  height: 200,
                  width: 200,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: controller.selectedImagePath != ""
                      ? Image.file(
                          File(controller.selectedImagePath),
                          fit: BoxFit.cover,
                        )
                      : Center(child: Text("No Image")));
            },
          ),
          Consumer<ImageController>(
            builder: (context, controller, child) {
              return Text(controller.selectedImageSize == ""
                  ? ""
                  : "${controller.selectedImageSize}");
            },
          ),
          Consumer<ImageController>(
            builder: (context, controller, child) {
              return Text(controller.selectedImagePath == ""
                  ? ""
                  : "${controller.selectedImagePath}");
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    imageController.getImage(ImageSource.camera);
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    size: 45,
                  )),
              IconButton(
                  onPressed: () {
                    imageController.getImage(ImageSource.gallery);
                  },
                  icon: Icon(
                    Icons.image,
                    size: 45,
                  )),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                imageController.uploadImage(
                  path: imageController.selectedImagePath,
                );
              },
              child: Text("Upload image"))
        ],
      ),
    );
  }
}
