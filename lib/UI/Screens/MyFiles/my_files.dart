import 'package:flutter/material.dart';
import '../../Components/my_bottom_navbar.dart';
import 'components/body.dart';
import 'dart:convert';
import 'dart:io';
import 'package:universal_html/html.dart' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plant_house/utils/Constants.dart';

class MyFiles extends StatefulWidget {
  MyFiles({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }
  late Stream<QuerySnapshot> _stream;
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Plant_data');
  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  List<List<String>> itemList = [];

  generateCsv() async {
    String csvData = ListToCsvConverter().convert(itemList);
    if (kIsWeb) {
      final bytes = utf8.encode(csvData);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = 'item_export.csv';
      html.document.body!.children.add(anchor);
      anchor.click();
      html.Url.revokeObjectUrl(url);
    } else if (Platform.isAndroid) {
      Directory generalDownloadDir = Directory('storage/emulated.0/Download');
      final File file = await (File('${generalDownloadDir.path}/item_export.csv').create());
      await file.writeAsString(csvData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: StreamBuilder<QuerySnapshot>(
        stream: widget._stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Some error occured ${snapshot.error}");
          }
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            List<Map> items = documents
                .map((e) => {
                      'imageURL': e['imageURL'],
                      'location': e['location'],
                      'subTitle': e['subTitle'],
                      'title': e['title'],
                      'time': e['time']
                    })
                .toList();
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  Map thisItem = items[index];
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  itemList.add([
                    doc.get('location'),
                    doc.get('subTitle'),
                    doc.get('title'),
                    doc.get('time')
                  ]);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Text(
                                        '${thisItem['title']}'.toUpperCase(),
                                      ),
                                      subtitle: Text(
                                          '${thisItem['location']} \n${thisItem['time']}'),
                                      leading: SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: thisItem.containsKey('imageURL')
                                            ? Image.network(
                                                '${thisItem['imageURL']}')
                                            : Container(),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          CupertinoIcons
                                              .arrowtriangle_down_circle_fill,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          return const Text('');
        },
      ),
      bottomNavigationBar: const MyBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => generateCsv(),
        child: const Icon(Icons.download),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/home');
        },
        child: const Center(child: Text("My Files")),
      ),
      actions: [
        IconButton(
            onPressed: () {
              // Constants.prefs.setBool("loggedIn", false);
              Navigator.pushReplacementNamed(context, "/cam_page");
            },
            icon: const Icon(Icons.camera_alt_outlined))
      ],
    );
  }
}
