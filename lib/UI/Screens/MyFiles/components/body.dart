import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plant_house/utils/Constants.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  late Stream<QuerySnapshot> _stream;
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Plant_data');
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  List<List<String>> itemList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'time':e['time']
                    })
                .toList();
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  Map thisItem = items[index];
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  itemList.add([doc.get('location'), doc.get('subTitle'), doc.get('title'), doc.get('time')]);
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
                                      title: Text('${thisItem['title']}'.toUpperCase(),),
                                      subtitle: Text('${thisItem['location']} \n${thisItem['time']}'),
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
    );
  }
}