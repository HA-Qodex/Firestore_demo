import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fltr_firebase/controllers/firebase_controller.dart';
import 'package:fltr_firebase/controllers/image_controller.dart';
import 'package:fltr_firebase/services/firestore_service.dart';
import 'package:fltr_firebase/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static String? documentID;

  @override
  Widget build(BuildContext context) {
    final firebaseController = Provider.of<FirebaseController>(context);
    final imageController = Provider.of<ImageController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInputField(
                        enable: true,
                        hint: "Enter Name",
                        textEditingController:
                            firebaseController.nameController,
                        title: "Name",
                      ),
                      TextInputField(
                        enable: true,
                        hint: "Enter Age",
                        textEditingController: firebaseController.ageController,
                        title: "Age",
                      ),
                      Text(
                        "Image",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Consumer<FirebaseController>(
                              builder: (context, controller, child) {
                                return Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  child: Center(
                                    child: Text(
                                      "${controller.selectedImagePath == "" ? "" : controller.selectedImagePath}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              firebaseController.pickImage(ImageSource.camera);
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              size: 45,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              firebaseController.pickImage(ImageSource.gallery);
                            },
                            icon: Icon(Icons.image, size: 45),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              firebaseController.uploadImage(
                                path: firebaseController.selectedImagePath,
                              );
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                                onPrimary: Colors.white),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              firebaseController.updateData(documentID!);
                            },
                            child: Text("Update",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                                onPrimary: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                )),
            Expanded(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: firebaseController.getData(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          print("====Error====");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                    title: Text(
                                        "${snapshot.data!.docs[index]["name"]}"),
                                    subtitle: Text(
                                        "${snapshot.data!.docs[index]["age"]}"),
                                    trailing: IconButton(
                                      onPressed: () {
                                        documentID =
                                            snapshot.data!.docs[index].id;
                                        firebaseController.editData(
                                            name: snapshot.data!.docs[index]
                                                ["name"],
                                            age: snapshot.data!.docs[index]
                                                ["age"],);
                                        print("id check:" + documentID!);
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          snapshot.data!.docs[index]["image"]),
                                    )

                                    /*IconButton(
                                    onPressed: () {
                                      documentID =
                                          snapshot.data!.docs[index].id;
                                      firebaseController
                                          .deleteData(documentID!);
                                    },
                                    icon: Icon(Icons.delete_forever_sharp),
                                  ),*/
                                    ),
                                Divider(),
                              ],
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                          physics: BouncingScrollPhysics(),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
