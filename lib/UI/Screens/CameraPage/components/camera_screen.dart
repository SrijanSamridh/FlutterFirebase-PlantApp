import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? _image;

  Future getImage(ImageSource source) async {
    try{
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
    }on PlatformException catch (e){
      print('Failed to pick image');
    }
  }

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  dynamic db = FirebaseFirestore.instance;


  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Card(
            child: Column(
              children: [
                Form(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controllerTitle,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                              icon: Icon(Icons.near_me),
                              hintText: "Enter the name of the item",
                              labelText: "Image Title"),
                        ),
                        TextFormField(
                          controller: _controllerQuantity,
                          style: const TextStyle(color: Colors.black),
                          obscureText: false,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.production_quantity_limits),
                              hintText: "Enter the quantity of the item",
                              labelText: "Quantity"),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                          String dataTitle = _controllerTitle.text;
                          String dataQuantity = _controllerQuantity.text;

                          if(dataTitle != "" || dataQuantity != ""){
                            //Create a Map of data
                            Map<String, String> dataToSend = {
                              'title': dataTitle,
                              'quantity': dataQuantity
                            };

                            //Add a new data
                            CollectionReference ref = FirebaseFirestore.instance.collection('Plant_data');
                            ref.add(dataToSend);

                            print('lalalalallal done');
                            _controllerQuantity.clear();
                            _controllerQuantity.clear();
                          }

                      },
                    style: ElevatedButton.styleFrom(
                        elevation: 12.0,
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(color: Colors.white)),
                    child: const Text('Submit'),
                  ),
                ),
                const SizedBox(height: 40),
                _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : Image.asset("assets/icons/AppLogo.jpg"),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          ImagePicker imagePicker = ImagePicker();
          XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
          print('${file?.path}');

          if(file == null) return;
          // Unique path string
          String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

          // creating the reference
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot.child('images');

          // creating the final file where the images will be stored
          Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

          try{
            // store the file
            await referenceImageToUpload.putFile(File(file.path));
            // Success: get the download URl
            imageUrl = await referenceImageToUpload.getDownloadURL();
          }catch(error){
            // some error occurred

          }
        },
        child: const Icon(Icons.camera_alt_outlined),
      ),
    );
  }
}
