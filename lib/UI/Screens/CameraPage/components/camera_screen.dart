import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  var _locationMessage = "";

  Future<void> getLocation() async{
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();


    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _locationMessage = "Long: ${position.longitude}\nLat: ${position.latitude}";
      _timeStamp = position.timestamp!;
    });
  }

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
  final TextEditingController _controllerSubTitle = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();


  String _imageUrl = '';
  late DateTime _timeStamp;

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
                              hintText: "Enter the Title",
                              labelText: "Image Title"),
                        ),
                        TextFormField(
                          controller: _controllerSubTitle,
                          style: const TextStyle(color: Colors.black),
                          obscureText: false,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.subtitles),
                              hintText: "Enter the Sub Title",
                              labelText: "Sub Title"),
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
                          String dataSubTitle = _controllerSubTitle.text;
                          String imageLocation = _locationMessage;
                          String imageInfo = _imageUrl;
                          String timeStamp = _timeStamp.toString();

                          if(dataTitle != ""){
                            //Create a Map of data
                            Map<String, String> dataToSend = {
                              'title': dataTitle,
                              'subTitle': dataSubTitle,
                              'location': imageLocation,
                              'imageURL': imageInfo,
                              'time': timeStamp
                            };

                            //Add a new data
                            CollectionReference ref = FirebaseFirestore.instance.collection('Plant_data');
                            ref.add(dataToSend);

                            _controllerTitle.clear();
                            _controllerSubTitle.clear();
                          }
                          Navigator.pushReplacementNamed(context, '/my_files');
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
                    ? Image.file(_image!, width: 250, height: 250, fit: BoxFit.cover)
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
          // print('${file?.path}');

          if(file == null) return;
          // Unique path string
          String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

          // creating the reference
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot.child('images');

          // creating the final file where the images will be stored
          Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
          getLocation();
          _image = File(file.path);
          try{
            // store the file
            await referenceImageToUpload.putFile(File(file.path));
            // Success: get the download URl
            _imageUrl = await referenceImageToUpload.getDownloadURL();
          }catch(error){
            // some error occurred
          }
        },
        child: const Icon(Icons.camera_alt_outlined),
      ),
    );
  }
}
